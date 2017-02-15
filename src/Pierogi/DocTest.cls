Class Pierogi.DocTest
{

ClassMethod GetDocCodes() As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		
		Set tSql = "Select Parent As Class, Name As Method, Description As Block "_
			" FROM %Dictionary.MethodDefinition "_
			" Where parent %StartsWith ? " _
			"   And Abstract = 0 " _
			"   And (Description like '%Examples%' OR Description like '%<example>%') "_
			" Order by SequenceNumber ",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		Set tRS = tStatement.execute(..DocTest())
		
		While tRS.%Next() {
			$$$THROWONERROR(tSC, ..Parser(tRS.%Get("Class"), tRS.%Get("Method"), tRS.%Get("Block") ))
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod Parser(pClass As %String, pMethod As %String, pBlock As %String) As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

