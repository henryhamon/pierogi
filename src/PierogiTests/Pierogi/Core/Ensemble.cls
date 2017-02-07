Class PierogiTests.Pierogi.Core.Ensemble Extends %UnitTest.TestCase
{

Method ItShouldBeEqual(pValue, pExpected)
{
	Do $$$AssertEquals(pValue, pExpected, "Expected: " _ $Get(pExpected) _ " Got: "_$Get(pValue))
}

Method TestGetDispatchName()
{
	Do ##class(Pierogi.core.Ensemble).RunTimeInfo("bsOrder",.tConfigName,.tClassName)
	Do ..ItShouldBeEqual(tConfigName,"bsOrder")
	Do ..ItShouldBeEqual(tClassName,"SamplePrj.PierogiDelivery.Service.Order")
}

}

