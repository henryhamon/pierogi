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

Method TestAssertFalse()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.False($$$YES)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(1).Ok)
	
	Do expectation.False($$$NO)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(2).Ok)
}

Method TestStatusOk()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Ok($$$OK)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Ok($$$ERROR(5002,"Oops!...I Did It Again"))
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestStatusNotOk()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.NotOk($$$ERROR(5002,"Oops!...I Did It Again"))
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.NotOk($$$OK)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestAssertEqual()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Equal(1,1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	
	Do expectation.Equal(1,2)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestResult()
{
}

}

