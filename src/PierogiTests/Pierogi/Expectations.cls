Class PierogiTests.Pierogi.Expectations Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method ExpectationFactory() As Pierogi.Expectations
{
	Quit ##class(Pierogi.Expectations).%New()
}

Method TestAssertIncrementNumber()
{
	S assert1 = ##class(Pierogi.Assert).%New()
	D ..ItShouldBeEqual(assert1.Number,1)
	
	S assert2 = ##class(Pierogi.Assert).%New(1)
	D ..ItShouldBeEqual(assert2.Number,2)
}

Method TestAssertTrue()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.True($$$YES)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	
	Do expectation.True($$$NO)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestAssertFalse()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.False($$$YES)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(1).Ok)
	
	Do expectation.False($$$NO)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(2).Ok)
}

Method TestStatusOk()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.Ok($$$OK)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Ok($$$ERROR(5002,"Oops!...I Did It Again"))
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestStatusNotOk()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.NotOk($$$ERROR(5002,"Oops!...I Did It Again"))
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.NotOk($$$OK)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestAssertEqual()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.Equal(1,1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	
	Do expectation.Equal(1,2)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestRange()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.Within(25, 5, 50)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Within(2, 5, 50)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	
	Do expectation.Approximately(3.49, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Approximately(2.5, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	
	Do expectation.CloseTo(3.49, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.CloseTo(2.5, 3.5, 0.01)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestComparisons()
{
	Set expectation = ..ExpectationFactory()
	
	Do expectation.Above(50, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Above(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.GreaterThan(50, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.GreaterThan(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.IsAtLeast(25, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsAtLeast(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Do expectation.IsAtLeast(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),3)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(3).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.Below(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Below(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.LessThan(2, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.LessThan(26, 25)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
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
	Set expectation = ..ExpectationFactory(), 
		test = ##class(%ListOfObjects).%New()
	
	Do expectation.IsObject(test)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsObject(1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.IsNotObject(1)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.IsNotObject(test)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory(), 
		test2 = ##class(%ArrayOfDataTypes).%New()
	
	Do expectation.TypeOf(test,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.TypeOf(test2,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.NotTypeOf(test2,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.NotTypeOf(test,"%Library.ListOfObjects")
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

Method TestStringComparison()
{
	Set expectation = ..ExpectationFactory(), 
		emailvalidator = "^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$"
	Do expectation.Match("john@doe.com",emailvalidator)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Match("john@doe.something",emailvalidator)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.Regex("john@doe.com",emailvalidator)
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.Regex("john@doe.something",emailvalidator)
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)

	Set expectation = ..ExpectationFactory()
	Do expectation.NotMatch("john@doe.something",emailvalidator)	
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.NotMatch("john@doe.com",emailvalidator)	
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)

	Set expectation = ..ExpectationFactory()
	Do expectation.StartWith("foobar","foo")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.StartWith("barfoo","foo")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.EndWith("foobar","bar")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.EndWith("barfoo","bar")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
	
	Set expectation = ..ExpectationFactory()
	Do expectation.EqualIgnoreCase("abcdef","AbCdEf")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),1)
	Do ..ItShouldBeTrue(expectation.Results.GetAt(1).Ok)
	
	Do expectation.EqualIgnoreCase("abcdef","AbdEf")	
	Do ..ItShouldBeEqual(expectation.Results.Count(),2)
	Do ..ItShouldBeFalse(expectation.Results.GetAt(2).Ok)
}

}

