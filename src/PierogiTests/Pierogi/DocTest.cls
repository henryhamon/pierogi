Class PierogiTests.Pierogi.DocTest Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method TestRun()
{
	Do ..ItShouldBeOk(##class(Pierogi.DocTest).Run( ##class(SampleTest.Suite).ProjectPackage(), .tResults))
	#Dim tResults As Pierogi.Results
	Do ..ItShouldBeEqual(tResults.Tests(),4)
}

}

