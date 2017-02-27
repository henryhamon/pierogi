Class Pierogi.Assertions [ Abstract ]
{

Property Status As %String [ InitialExpression = "succeed", Internal ];

Property Results As list Of Pierogi.Assert;

Property Fails As list Of Pierogi.Assert;

Property Succeeds As list Of Pierogi.Assert;

Method Clear() As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		$$$THROWONERROR(tSC, ..Results.Clear())
		$$$THROWONERROR(tSC, ..Fails.Clear())
		$$$THROWONERROR(tSC, ..Succeeds.Clear())
		Set ..Status = "succeed"
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

/// Assert that value is true.
Method True(pValue As %Boolean)
{
	Do ..SetResults(..Test("True", pValue,..Message("True",$Select(pValue="":"False",0:"False",1:"True"))))
}

/// Assert that value is false.
Method False(pValue As %Boolean)
{
	Do ..SetResults(..Test("False", 'pValue, ..Message("False",$Select(pValue="":"True",0:"True",1:"False"))))
}

/// Assert that status is OK
Method Ok(pValue)
{
	Set st="Status OK", actual = st
	Set:$$$ISERR(pValue) actual = $System.Status.GetErrorText(pValue)
	Do ..SetResults(..Test("Ok", $$$ISOK(pValue), ..Message(st, actual)))
}

/// Assert that status is Not OK
Method NotOk(pValue)
{
	Set st="Status Not OK", actual = st
	Set:$$$ISOK(pValue) actual = "Status OK"
	Do ..SetResults(..Test("NotOk", $$$ISERR(pValue), ..Message(st, actual)))
}

/// Assert Should Be Equal
Method Equal(pValue, pExpected)
{
	Do ..SetResults(..Test("Equal", pValue = pExpected,..Message(pExpected, pValue)))
}

/// Assert Should Be Equal
Method Eql(pValue, pExpected)
{
	Do ..Equal(pValue, pExpected)
}

/// Assert Should Be Exact the same
Method Exactly(pValue, pExpected)
{
	Do ..SetResults(..Test("Exactly", pValue = pExpected,..Message(pExpected, pValue)))
}

ClassMethod Message(pExpected = "", pGot = "", pBR = "") As %String
{
	Set:pBR="" pBR = " "
	Quit "Expected: " _ $Get(pExpected) _ pBR _"Actual: "_$Get(pGot)
}

Method Test(pName As %String, pResult As %Boolean = 0, pMessage As %String = "") As Pierogi.Assert [ Private ]
{
	Set tAssert = ##class(Pierogi.Assert).Satisfy( ..Results.Count(), pName, pResult, pMessage )
	Set:tAssert.Ok=$$$NO ..Status = "fail"
	
	Quit tAssert
}

Method Status()
{
	Quit ..Status
}

Method SetResults(pAssert As Pierogi.Assert) As %Status
{
	Set tSC = $$$OK
	Try {
		Do ..Results.Insert(pAssert)
		
		If pAssert.Ok {
			Do ..Succeeds.Insert(pAssert)
		} Else {
			Do ..Fails.Insert(pAssert) 
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

