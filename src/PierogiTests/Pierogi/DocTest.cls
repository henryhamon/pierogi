Class PierogiTests.Pierogi.DocTest Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method TestRun()
{
	Set docTest = ##class(Pierogi.DocTest).%New( ##class(SampleTest.Suite).ProjectPackage(), 0)
	Do ..ItShouldBeOk(docTest.Run( .tResults))
	
	#Dim tResults As Pierogi.Results
	Do ..ItShouldNotBeOk(tResults.Status)
	Do ..ItShouldBeEqual(tResults.Tests(), 5)
	Do ..ItShouldBeEqual(tResults.Pass, 3)
	Do ..ItShouldBeEqual(tResults.Fail, 2)
}

}

