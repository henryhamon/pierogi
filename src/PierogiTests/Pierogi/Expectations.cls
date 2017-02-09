Class PierogiTests.Pierogi.Expectations Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method TestAssertIncrementNumber()
{
	S assert1 = ##class(Pierogi.Assert).%New()
	D ..ItShouldBeEqual(assert1.Number,1)
	
	S assert2 = ##class(Pierogi.Assert).%New(1)
	D ..ItShouldBeEqual(assert2.Number,2)
}

Method TestAssertTrue()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.True($$$YES)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	
	Do expectation.True($$$NO)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestStatusOk()
{
	
	;;Do ..ItShouldBeTrue()
}

Method TestResult()
{
}

}

