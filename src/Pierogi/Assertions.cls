Class Pierogi.Assertions [ Abstract ]
{

Property Results As list Of Pierogi.Assert;

/// Assert that value is true.
Method True(pValue As %Boolean)
{
	Do ..Results.Insert(..Test(pValue,..Message("True",$Select(pValue="":"False",0:"False",1:"True"))))
}

/// Assert that value is false.
Method False(pValue As %Boolean)
{
	Do ..Results.Insert(..Test('pValue, ..Message("False",$Select(pValue="":"True",0:"True",1:"False"))))
}

ClassMethod Message(pExpected = "", pGot = "", pBR = "") As %String [ Private ]
{
	Set:pBR="" pBR = " "
	Quit "Expected: " _ $Get(pExpected) _ pBR _"Actual: "_$Get(pGot)
}

Method Test(pResult As %Boolean = 0, pMessage As %String) As Pierogi.Assert [ Private ]
{
	Set tAssert = ##class(Pierogi.Assert).%New( ..Results.Count() ), 
		tAssert.Ok = pResult = $$$YES
	Set:tAssert.Ok tAssert.Msg = pMessage
	
	Quit tAssert
}

}

