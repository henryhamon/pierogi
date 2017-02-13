Class Pierogi.Assertions [ Abstract ]
{

Property Status As %String [ InitialExpression = "succeed", Internal ];

Property Results As list Of Pierogi.Assert;

Property Fails As list Of Pierogi.Assert;

/// Assert that value is true.
Method True(pValue As %Boolean)
{
	Do ..Results.Insert(..Test("True", pValue,..Message("True",$Select(pValue="":"False",0:"False",1:"True"))))
}

/// Assert that value is false.
Method False(pValue As %Boolean)
{
	Do ..Results.Insert(..Test("False", 'pValue, ..Message("False",$Select(pValue="":"True",0:"True",1:"False"))))
}

/// Assert that status is OK
Method Ok(pValue)
{
	Set st="Status OK", actual = st
	Set:$$$ISERR(pValue) actual = $System.Status.GetErrorText(pValue)
	Do ..Results.Insert(..Test("Ok", $$$ISOK(pValue), ..Message(st, actual)))
}

/// Assert that status is Not OK
Method NotOk(pValue)
{
	Set st="Status Not OK", actual = st
	Set:$$$ISOK(pValue) actual = "Status OK"
	Do ..Results.Insert(..Test("NotOk", $$$ISERR(pValue), ..Message(st, actual)))
}

ClassMethod Message(pExpected = "", pGot = "", pBR = "") As %String [ Private ]
{
	Set:pBR="" pBR = " "
	Quit "Expected: " _ $Get(pExpected) _ pBR _"Actual: "_$Get(pGot)
}

Method Test(pName As %String, pResult As %Boolean = 0, pMessage As %String) As Pierogi.Assert [ Private ]
{
	Set tAssert = ##class(Pierogi.Assert).%New( ..Results.Count() ), 
		tAssert.Ok = pResult, 
		tAssert.Name = pName
	If tAssert.Ok=$$$NO {
		Set tAssert.Msg = pMessage,
			..Status = "fail"
		
		Do ..Fails.Insert(tAssert) // Temporary solution TODO: must refactor
	}
	
	Quit tAssert
}

Method Status()
{
	Quit ..Status
}

}

