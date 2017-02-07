Class PierogiTests.Pierogi.Core.Ensemble Extends %UnitTest.TestCase
{

Method ItShouldBeEqual(pValue, pExpected)
{
	Do $$$AssertEquals(pValue, pExpected, "[Expected]: " _ $Get(pExpected) _ " [Got]: "_$Get(pValue))
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

Method TestGetRunTimeInfo()
{
	Do ..ItShouldBeOk(##class(Pierogi.core.Ensemble).RunTimeInfo("bsOrder",.tConfigName,.tClassName))
	Do ..ItShouldBeEqual(tConfigName,"bsOrder")
	Do ..ItShouldBeEqual(tClassName,"SamplePrj.PierogiDelivery.Service.Order")
}

Method TestInvalidEnsembleObject()
{
	Do ..ItShouldBeOk(##class(Pierogi.core.Ensemble).RunTimeInfo("businessServiceInvalidName",.tConfigName,.tClassName))
	Do ..ItShouldBeEqual(tConfigName,"")
	Do ..ItShouldBeEqual(tClassName,"")
}

Method TestIfIsABusinessService()
{
	Do ..ItShouldBeTrue(##class(Pierogi.core.Ensemble).IsAService("SamplePrj.PierogiDelivery.Service.Order"))
	Do ..ItShouldBeFalse(##class(Pierogi.core.Ensemble).IsAService("SamplePrj.PierogiDelivery.Service.Invalid"))
	Do ..ItShouldBeFalse(##class(Pierogi.core.Ensemble).IsAService("SamplePrj.PierogiDelivery.Operation.Client"))
}

}

