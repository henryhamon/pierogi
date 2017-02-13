Class Pierogi.Suite Extends %RegisteredObject [ Abstract ]
{

Parameter Terminal = 1;

/// Abstract method that should return the name of the package 
/// where the test cases are located.
ClassMethod Package() As %String [ Abstract ]
{
	Quit ""
}

/// Returns a list of specs and tests cases based on what is returned
/// from the <method>Package</method> class method.
ClassMethod Specs()
{
	Do $system.OBJ.GetPackageList(.classList, ..Package())
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
	Set tResults = ##class(Pierogi.Results).%New()
	Try {
		Set tResults.Status = $$$OK
		Do ..TerminalCls()
		
		Set specsClass = ..Specs(), idx = 1
		While (( idx > 0) && (idx <= $ListLength(specsClass))){
			
			$$$THROWONERROR(tSC, ..RunTest($List(specsClass,idx), .tResults))
			
			Set idx = $Increment(idx)
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		Set tResults.Status = tSC
	}
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
			
			$$$THROWONERROR(tSC, pClass.Results.Clear())
			Do $Method(pClass, test)
			$$$THROWONERROR(tSC, pResults.Add(pClass.Status))
			
			Do:(pClass.Status="fail" && ..#Terminal) ..TerminalPrintFail()
			 
			Do:(pClass.Status="succeed" && ..#Terminal) ..TerminalPrintPass()
			
			
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
		
		If ..#Terminal=$$$YES {
			Do ..TerminalClass(pClass)
		}
		
		$$$THROWONERROR(tSC, ..LifecycleHooks(class, specs, .pResults))
	
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod TerminalCls()
{
	Write #,!,*12
}

ClassMethod TerminalClass(pClassName As %String)
{
	Write !,*27,"[0m",pClassName,*27,"[0m",!
}

ClassMethod TerminalPrintPass()
{
	Write *27,"[32m",".",*27,"[0m"
}

ClassMethod TerminalPrintFail()
{
	Write *27,"[31m","F",*27,"[0m"
}

ClassMethod TerminalResume()
{
}

}

