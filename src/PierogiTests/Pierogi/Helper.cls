Class PierogiTests.Pierogi.Helper Extends %UnitTest.TestCase
{

// Asserts ----------------------------------------------------------------------------------------------

Method ItShouldBeEqual(pValue, pExpected)
{
	Set:$Get(pExpected)="" pExpected = "NULL"
	Set:$Get(pValue)="" pValue = "NULL"
	Do $$$AssertEquals(pValue, pExpected, "[Expected]: " _ pExpected _ " [Got]: "_pValue)
}

Method ItShouldBeTrue(pValue)
{
	Do ..ItShouldBeEqual(pValue, $$$YES)
}

Method ItShouldBeFalse(pValue)
{
	Do ..ItShouldBeEqual(pValue, $$$NO)
}

Method ItShouldBeOk(pStatus)
{
	Set descerr = "OK"
	Set:$$$ISERR(pStatus) descerr = $System.Status.GetErrorText(pStatus)
	Do $$$AssertStatusOK(pStatus, "[Expected]: OK [Got]: "_$Get(descerr))
}

}

