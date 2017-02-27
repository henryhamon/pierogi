Class Pierogi.Suite Extends %RegisteredObject [ Abstract ]
{

Parameter Terminal = 1;

/// Abstract method that should return the name of the package 
/// where the test cases are located.
ClassMethod SpecsPackage() As %String [ Abstract ]
{
	Quit ""
}

ClassMethod TestPackage() As %String [ Abstract ]
{
	Quit ""
}

ClassMethod Package() As %String [ Abstract ]
{
	Quit ""
}

/// Optional method that should return the name of the package 
/// where the project classes are located.
ClassMethod ProjectPackage() As %String
{
	Quit ""
}

ClassMethod GetSpecsPackage() As %String [ Internal ]
{
	Set package = ..SpecsPackage()
	Set:package="" package = ..TestPackage()
	Set:package="" package = ..Package()
	Quit package
}

/// Returns a list of specs and tests cases based on what is returned
/// from the <method>Package</method> class method.
ClassMethod Specs()
{
	Set package = ..GetSpecsPackage()
	Quit:package=""
	
	Do $system.OBJ.GetPackageList(.classList, package)
	Set class = $Order(classList(""))
	Set testList = ""
	
	While class'="" {
		Set:($$issubclassof^%occCompile(class,"Pierogi.Spec")
		   && '##class(%Dictionary.ClassDefinition).%OpenId(class).Abstract) $List(testList, *+1) = class
			
		Set class = $Order(classList(class))
	}
	
	Quit testList
}

ClassMethod RunnableMethods(pClassname As %String, Output pTests) As %Status
{
	Set tSC = $$$OK
	Try {
		Set pTests="",
			tSql = "Select Name from %Dictionary.MethodDefinition " _
				" Where parent = ? " _
				" AND ( Name %StartsWith 'Should' OR  Name %StartsWith 'Test') " _
				" Order by SequenceNumber ",
			tStatement =  ##class(%SQL.Statement).%New()
			
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		Set tRS = tStatement.execute(pClassname)
		
		While tRS.%Next() {
			Set $List(pTests, *+1) = tRS.%Get("Name")
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod Run() As Pierogi.Results
{
	Set tSC = $$$OK, 
		tResults = ##class(Pierogi.Results).%New()
	Try {
		Set zhmBegin=$zh, 
			tResults.Status = $$$OK
			
		Do:..#Terminal ##class(Pierogi.TerminalDisplay).Cls()
		
		// Run DocTest
		$$$THROWONERROR(tSC, ..RunDocTests(.tResults))
		
		Set specsClass = ..Specs(), idx = 1
		While (( idx > 0) && (idx <= $ListLength(specsClass))){
			
			$$$THROWONERROR(tSC, ..RunTest($List(specsClass,idx), .tResults))
			
			Set idx = $Increment(idx)
		}
		
		Set zhmDuration=$zh-zhmBegin
		Do:..#Terminal ##class(Pierogi.TerminalDisplay).FinishedIn(zhmDuration)
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		Set tResults.Status = tSC
	}
	
	Do:..#Terminal ##class(Pierogi.TerminalDisplay).Resume(tResults)

	Quit tResults
}

ClassMethod LifecycleHooks(pClass, pRunnableMethods, ByRef pResults As Pierogi.Results) As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		// LifeCycleHooks
		Do pClass.BeforeSetup()
		// For Each Test
		For k=1:1:$ListLength(pRunnableMethods){
			Set test = $List(pRunnableMethods,k)

			Do pClass.Before()
			
			$$$THROWONERROR(tSC, pClass.Clear())
			Do $Method(pClass, test)
			$$$THROWONERROR(tSC, pResults.Add(pClass, test))
			
			Do:(pClass.Status="fail" && ..#Terminal) ##class(Pierogi.TerminalDisplay).Fail()
			Do:(pClass.Status="succeed" && ..#Terminal) ##class(Pierogi.TerminalDisplay).Pass()
			
			Do pClass.After()
		}
		
		Do pClass.AfterSetup()
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod RunTest(pClass As %String, ByRef pResults As Pierogi.Results) As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		Set class = $ClassMethod(pClass,"%New")
		#Dim class As Pierogi.Spec
		$$$THROWONERROR(tSC, ..RunnableMethods(pClass, .specs))
		$$$THROWONERROR(tSC, ..LifecycleHooks(class, specs, .pResults))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod RunDocTests(ByRef pResults As Pierogi.Results) As %Status [ Private ]
{
	Set tSC = $$$OK
	Quit:..ProjectPackage()="" tSC
	Try {
		Set DocTest = ##class(Pierogi.DocTest).%New(..ProjectPackage(), ..#Terminal)
		$$$THROWONERROR(tSC, DocTest.Run(.pResults))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

