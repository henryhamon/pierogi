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
		Set:(($$issubclassof^%occCompile(class,"Pierogi.Spec")||$$issubclassof^%occCompile(class,"Pierogi.Ensemble"))
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
				" AND ( Name %StartsWith 'Should' OR  Name %StartsWith 'Test' OR Name %StartsWith 'Deve' OR Name %StartsWith 'Deveria') " _
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

ClassMethod All() As Pierogi.Results
{
	Quit ..RunTests(..Specs())
}

ClassMethod Run(pRecipe As %String = "") As Pierogi.Results
{
	
	Quit:pRecipe="" ..RunTests(..Specs())
	
	Set tSC = $$$OK, 
		tResults = ##class(Pierogi.Results).%New()
	Try {
		Set package = ..GetSpecsPackage()
		Set:package="" tSC = $$$ERROR(5114)
		Throw:$$$ISERR(tSC)
		
		Set pTests="", recipes = "",
			tSql = " Select Name FROM %Dictionary.ClassDefinition " _
					" Where Abstract <> 1 " _
					" AND (Super = 'Pierogi.Spec' OR Super = 'Pierogi.Ensemble') " _
					" AND ID %StartsWith '"_package_"' " _
					" AND NAME Like '%"_pRecipe_"%' ",
			tStatement =  ##class(%SQL.Statement).%New()
		
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		
		
		Set tRS = tStatement.execute()
		
		While tRS.%Next() {
			Set $List(recipes, *+1) = tRS.%Get("Name")
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		Set tResults.Status = tSC
	}
	
	Quit:$$$ISERR(tSC) tResults
	Quit ..RunTests(recipes, pRecipe)
}

ClassMethod RunTests(pRecipes, pDocClass As %String = "") As Pierogi.Results [ Private ]
{
	Set tSC = $$$OK, 
		tResults = ##class(Pierogi.Results).%New()
	Try {
		$$$THROWONERROR(tSC, ..Setup(.tResults, .zhmBegin))
		
		// Run DocTest
		$$$THROWONERROR(tSC, ..RunDocTests(.tResults, pDocClass))
		
		Set idx = 1
		While (( idx > 0) && (idx <= $ListLength(pRecipes))){
			$$$THROWONERROR(tSC, ..RunTest($List(pRecipes,idx), .tResults))
			
			Set idx = $Increment(idx)
		}
		
		$$$THROWONERROR(tSC, ..BeforeTeardown(tResults, zhmBegin))
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		Set tResults.Status = tSC
	}
	
	Do ..Teardown(tResults)

	Quit tResults
}

/// During development it can be helpful to only run a few specific tests.
/// <br>
/// This can be accomplished using the Only method.
ClassMethod Only(pSpec As %String) As Pierogi.Results
{
	Set tSC = $$$OK, 
		tResults = ##class(Pierogi.Results).%New()
	Try {
		
		$$$THROWONERROR(tSC, ..Setup(.tResults, .zhmBegin))
		
		Set tSql = "Select Name As Method, Parent as Class from %Dictionary.MethodDefinition " _
				" Where parent %StartsWith ? " _
				" AND upper(Name) %StartsWith upper(?) " _
				" Order by SequenceNumber ",
			tStatement =  ##class(%SQL.Statement).%New()
			
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		Set tRS = tStatement.execute(..GetSpecsPackage(), pSpec )
		
		While tRS.%Next() {
			Set class = $ClassMethod(tRS.%Get("Class"),"%New")
			$$$THROWONERROR(tSC, ..LifecycleHooks(class, $ListBuild(tRS.%Get("Method")), .tResults))
		}
		
		$$$THROWONERROR(tSC, ..BeforeTeardown(tResults, zhmBegin))
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		Set tResults.Status = tSC
	}
	Do ..Teardown(tResults)
	
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

			$$$THROWONERROR(tSC, pClass.Clear())
			Do pClass.Before()

			Do $Method(pClass, test)
			$$$THROWONERROR(tSC, pResults.Add(pClass, test))
			
			Do:(pClass.Status="fail" && ..#Terminal) ##class(Pierogi.TerminalDisplay).Fail()
			Do:(pClass.Status="succeed" && ..#Terminal) ##class(Pierogi.TerminalDisplay).Pass()
			
			Do pClass.After()
		}
		
		Do pClass.AfterTeardown()
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

ClassMethod RunDocTests(ByRef pResults As Pierogi.Results, pDocClass As %String = "") As %Status [ Private ]
{
	Set tSC = $$$OK
	Quit:..ProjectPackage()="" tSC
	Try {
		Set DocTest = ##class(Pierogi.DocTest).%New(..ProjectPackage(), ..#Terminal)
		$$$THROWONERROR(tSC, DocTest.Run(.pResults, pDocClass))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod Setup(ByRef pResults As Pierogi.Results, Output pStartingTime) As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		Set pStartingTime 	= $ZHorolog, 
			pResults.Status = $$$OK

		Do:..#Terminal ##class(Pierogi.TerminalDisplay).Cls()
			
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod BeforeTeardown(pResults As Pierogi.Results, pStartingTime, Output pDuration) As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		Set pDuration = $ZHorolog - pStartingTime
		Do:..#Terminal ##class(Pierogi.TerminalDisplay).FinishedIn(pDuration)
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod Teardown(pResults As Pierogi.Results) As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		
		Do:..#Terminal ##class(Pierogi.TerminalDisplay).Resume(pResults)
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

