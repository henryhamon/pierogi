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

Method TestRange()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Within(25, 5, 50)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Within(2, 5, 50)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Approximately(3.49, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Approximately(2.5, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.CloseTo(3.49, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.CloseTo(2.5, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestComparisons()
{
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Above(50, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Above(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.GreaterThan(50, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.GreaterThan(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.IsAtLeast(25, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsAtLeast(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Do expectation.IsAtLeast(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),3)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(3).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.Below(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Below(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.LessThan(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.LessThan(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.IsAtMost(25, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsAtMost(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Do expectation.IsAtMost(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),3)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(3).Ok)
}

Method TestIsObject()
{
	Set expectation = ##class(Pierogi.Expectations).%New(), 
		test = ##class(%ListOfObjects).%New()
	
	Do expectation.IsObject(test)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsObject(1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.IsNotObject(1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsNotObject(test)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New(), 
		test2 = ##class(%ArrayOfDataTypes).%New()
	
	Do expectation.TypeOf(test,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.TypeOf(test2,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ##class(Pierogi.Expectations).%New()
	
	Do expectation.NotTypeOf(test2,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.NotTypeOf(test,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestResult()
{
}

}

