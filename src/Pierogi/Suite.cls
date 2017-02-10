Class Pierogi.Suite Extends %RegisteredObject [ Abstract ]
{

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

ClassMethod SpecTests(pClassname As %String, Output pTests) As %Status
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

}

