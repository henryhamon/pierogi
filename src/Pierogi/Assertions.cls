Class Pierogi.Assertions [ Abstract ]
{

Property Status As %String [ InitialExpression = "succeed", Internal ];

Property Results As list Of Pierogi.Assert;

Property Fails As list Of Pierogi.Assert;

Property Succeeds As list Of Pierogi.Assert;

Method Clear() As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		$$$THROWONERROR(tSC, ..Results.Clear())
		$$$THROWONERROR(tSC, ..Fails.Clear())
		$$$THROWONERROR(tSC, ..Succeeds.Clear())
		Set ..Status = "succeed"
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

/// Assert that value is true.
Method True(pValue As %Boolean)
{
	Do ..SetResults(..Test("True", pValue,..Message("True",$Select(pValue="":"False",0:"False",1:"True"))))
}

/// Assert that value is false.
Method False(pValue As %Boolean)
{
	Do ..SetResults(..Test("False", 'pValue, ..Message("False",$Select(pValue="":"True",0:"True",1:"False"))))
}

/// Assert that status is OK
Method Ok(pValue)
{
	Set st="Status OK", actual = st
	Set:$$$ISERR(pValue) actual = $System.Status.GetErrorText(pValue)
	Do ..SetResults(..Test("Ok", $$$ISOK(pValue), ..Message(st, actual)))
}

/// Assert that status is Not OK
Method NotOk(pValue)
{
	Set st="Status Not OK", actual = st
	Set:$$$ISOK(pValue) actual = "Status OK"
	Do ..SetResults(..Test("NotOk", $$$ISERR(pValue), ..Message(st, actual)))
}

/// Assert Should Be Equal
Method Equal(pValue, pExpected)
{
	Do ..SetResults(..Test("Equal", pValue = pExpected,..Message(pExpected, pValue)))
}

/// Assert Should Be Equal
Method Eql(pValue, pExpected)
{
	Do ..Equal(pValue, pExpected)
}

/// Assert Should Be Exact the same
Method Exactly(pValue, pExpected)
{
	Do ..SetResults(..Test("Exactly", pValue = pExpected,..Message(pExpected, pValue)))
}

/// Assert inclusive numeric range (<= to and >= from): <br/>
/// <br/>
/// Do ..Within(User.Age, 5, 50)
Method Within(pValue, pMin, pMax)
{
	Do ..SetResults(..Test("Within", ((pValue >= pMin)&&(pValue <= pMax)),..Message(pMin_".."_pMax, pValue)))
}

/// Assert floating point number near num within a +/- delta range.
/// <br/>
/// Do ..Approximately(3.49, 3.5, 0.01 )
Method Approximately(pValue As %Numeric, pExpected As %Numeric, pDelta As %Numeric = 0.01)
{
	Do ..CloseTo(pValue, pExpected, pDelta)
}

/// Asserts that the target is equal expected, to within a +/- delta range.
/// <br/>
/// Do ..CloseTo(1.5, 1, 0.5)
Method CloseTo(pValue As %Numeric, pExpected As %Numeric, pDelta As %Numeric = 0.5)
{
	Set pMin = (pExpected - pDelta), 
		pMax = (pExpected + pDelta)
	Do ..SetResults(..Test("Close To", ((pValue >= pMin)&&(pValue <= pMax)),..Message(pMin_".."_pMax, pValue)))
}

/// Above(num) and GreaterThan(num)<br/>
/// Assert numeric value above the given value (> num): <br/>
/// Do ..Above(User.Age, 5)
Method Above(pValue, pNum)
{
	Do ..SetResults(..Test("Above", (pValue > pNum),..Message("Above " _ pNum, pValue)))
}

/// Assert numeric value above the given value (> num):<br/>
/// Do ..GreaterThan(User.Age, 5)
Method GreaterThan(pValue, pNum)
{
	Do ..SetResults(..Test("Greater Than", (pValue > pNum),..Message("Greater than "_pNum, pValue)))
}

/// Assert is greater than or equal to (>=) valueToBeAtLeast(num)
Method IsAtLeast(pValue, pNum)
{
	Do ..SetResults(..Test("Is at Least", (pValue >= pNum),..Message("Is at Least " _ pNum, pValue)))
}

/// Below(num) and LessThan(num)<br/>
/// Assert numeric value below the given value (< num)<br/>
/// Do ..Below(User.Age, 50)
Method Below(pValue, pNum)
{
	Do ..SetResults(..Test("Below", (pValue < pNum),..Message(pNum_" > ", pValue)))
}

/// Assert numeric value below the given value (< num)<br/>
/// Do ..LessThan(User.Age, 50)
Method LessThan(pValue, pNum)
{
	Do ..SetResults(..Test("Less Than", (pValue < pNum),..Message("Less than "_pNum, pValue)))
}

/// Assert is less than or equal to (<=) valueToBeAtMost (num)
Method IsAtMost(pValue, pNum)
{
	Do ..SetResults(..Test("Is at Most", (pValue <= pNum),..Message("Is at Most " _ pNum, pValue)))
}

/// Asserts that value is an object
Method IsObject(pValue)
{
	Do ..SetResults(..Test("Is Object", $IsObject(pValue),..Message("Is Object")))
}

/// Asserts that value is NOT an object
Method IsNotObject(pValue)
{
	Do ..SetResults(..Test("Is Not Object", '$IsObject(pValue),..Message("Is not an Object")))
}

/// Asserts that value?s type is pClassName
/// <br/>
/// Do ..TypeOf(pClass, "%RegisteredObject" )
Method TypeOf(pValue, pClassName)
{
	Set got = $ClassName(pValue)
	Do ..SetResults(..Test("Type Of", got = pClassName,..Message("Type of "_pClassName, got)))
}

/// Asserts that value?s type is <b>not</b> pClassName
/// <br/>
/// Do ..NotTypeOf(pClass, "%RegisteredObject" )
Method NotTypeOf(pValue, pClassName)
{
	Set got = $ClassName(pValue)
	Do ..SetResults(..Test("Not Type Of", got '= pClassName,..Message("Is Not type of "_pClassName, got)))
}

/// Assert given object matches a Regex<br/>
/// Given: String, otherValue: regexp. Uses %Regex.Matcher:
/// 
Method Regex(pValue, pRegex)
{
	Do ..Match(pValue, pRegex)
}

Method Match(pValue, pRegex)
{
	Set matcher = ##class(%Regex.Matcher).%New(pRegex)
	Set matcher.Text = pValue
    Do ..SetResults(..Test("Match", matcher.Locate(),..Message("Match this pattern "_pRegex, pValue)))
}

Method NotMatch(pValue, pRegex)
{
	Set matcher = ##class(%Regex.Matcher).%New(pRegex)
	Set matcher.Text = pValue
    Do ..SetResults(..Test("Not Match", 'matcher.Locate(),..Message("Not Match this pattern "_pRegex, pValue)))
}

/// Assert that a string starts with str.
/// <br/>
/// Do ..StartsWith('foobar','foo')
Method StartsWith(pValue, pExpected)
{
	Set matcher = ##class(%Regex.Matcher).%New("^("_pExpected_")")
	Set matcher.Text = pValue
	
	Do ..SetResults(..Test("StartsWith", matcher.Locate(),..Message("starts with "_pExpected, pValue)))
}

Method StartWith(pValue, pExpected)
{
	Do ..StartsWith(pValue, pExpected)
}

/// Assert that a string ends with str.
/// <br/>
/// Do ..EndsWith('foobar','foo')
Method EndsWith(pValue, pExpected)
{
	Set matcher = ##class(%Regex.Matcher).%New(".*("_ pExpected _")$")
	Set matcher.Text = pValue
	Do ..SetResults(..Test("EndsWith", matcher.Locate(),..Message("ends with "_pExpected, pValue)))
}

Method EndWith(pValue, pExpected)
{
	Do ..EndsWith(pValue, pExpected)
}

Method EqualIgnoreCase(pValue, pExpected)
{
	Do ..SetResults(..Test("EqualIgnoreCase", $ZConvert(pValue,"l")=$ZConvert(pExpected,"l") ,..Message(pExpected, pValue)))
}

ClassMethod Message(pExpected = "", pGot = "", pBR = "") As %String
{
	Set:pBR="" pBR = " "
	Quit "Expected: " _ $Get(pExpected) _ pBR _"Actual: "_$Get(pGot)
}

Method Test(pName As %String, pResult As %Boolean = 0, pMessage As %String = "") As Pierogi.Assert [ Private ]
{
	Set tAssert = ##class(Pierogi.Assert).Satisfy( ..Results.Count(), pName, pResult, pMessage )
	Set:tAssert.Ok=$$$NO ..Status = "fail"
	
	Quit tAssert
}

Method Status()
{
	Quit ..Status
}

Method SetResults(pAssert As Pierogi.Assert) As %Status
{
	Set tSC = $$$OK
	Try {
		Do ..Results.Insert(pAssert)
		
		If pAssert.Ok {
			Do ..Succeeds.Insert(pAssert)
		} Else {
			Do ..Fails.Insert(pAssert) 
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

