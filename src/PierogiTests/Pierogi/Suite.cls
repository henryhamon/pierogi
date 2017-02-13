Class PierogiTests.Pierogi.Suite Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method TestPackageName()
{
	Do ..ItShouldBeEqual(##class(SampleTest.Suite).Package(),"SampleTest")
}

Method TestSpecList()
{
	Set specs = ##class(SampleTest.Suite).Specs()
	Do ..ItShouldBeEqual( $ListLength(specs), 2)
	Do ..ItShouldBeEqual( $List(specs,1), "SampleTest.spec01")
	Do ..ItShouldBeEqual( $List(specs,2), "SampleTest.spec02")
}

Method TestListAllRunnableMethods()
{
	Set specClass = $List(##class(SampleTest.Suite).Specs(),1)
	Do ..ItShouldBeEqual( specClass, "SampleTest.spec01")
	Do ..ItShouldBeOk(##class(SampleTest.Suite).RunnableMethods(specClass, .tests))
	Do ..ItShouldBeEqual( $ListLength(tests), 2)
	Do ..ItShouldBeEqual( $List(tests, 1),"ShouldTestOne")
	Do ..ItShouldBeEqual( $List(tests, 2),"ShouldFail")
}

Method TestRun()
{
	#Dim results AS Pierogi.Results
	
	Set results = ##class(SampleTest.Suite).Run()
	Do ..ItShouldBeEqual($ClassName(results),"Pierogi.Results")
	Do ..ItShouldBeEqual(results.Tests(),2)
	Do ..ItShouldBeEqual(results.Pass,1)
	Do ..ItShouldBeEqual(results.Fail,1)
}

}

