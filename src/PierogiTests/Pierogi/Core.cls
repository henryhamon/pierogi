Class PierogiTests.Pierogi.Core Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method TestShouldDescribe()
{
	Do ..ItShouldBeEqual(##class(PierogiTests.Mock.PierogiTest01).Describe(),"")
	Do ..ItShouldBeEqual(##class(PierogiTests.Mock.PierogiTest02).Describe(),"Describe a Pierogi Test 2")
}

}

