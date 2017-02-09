Class Pierogi.Asserts Extends %SerialObject
{

/// The number of the assertion
Property Number As %Integer;

/// Whether the assertion passed or failed
Property Ok As %Boolean;

/// The Name of the assertion
Property Name As %String;

/// The Expectation message when it fails
Property Msg As %String;

/// The Expectation that this Assert belongs
Property Expectation As %String;

/*

/// Assert that status is Not OK
Method NotOk(pValue, pMessage = "")
{
	Do $$$AssertStatusNotOK(pValue, pMessage)
}


/// Assert that value is false.
Method False(pValue, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("False",$Select(pValue="":"True",0:"True",1:"False"))
	Do $$$AssertNotTrue(pValue, pMessage)
}

/// Assert that value is not equal to expected
Method Not(pValue, pExpected, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message(pExpected,pValue)
	Do $$$AssertNotEquals(pValue, pExpected, pMessage)
}

/// Assert Should Be Equals 
Method Is(pValue, pExpected, pMessage = "")
{
 	Set:pMessage="" pMessage = ..Message(pExpected,pValue)
 	Do $$$AssertEquals(pValue, pExpected, pMessage)
}

/// Assert Should Be Equal
Method Equal(pValue, pExpected, pMessage = "")
{
	Do ..Is(pValue, pExpected, pMessage)
}

/// Assert Should Be Equal
Method Eql(pValue, pExpected, pMessage = "")
{
	Do ..Equal(pValue, pExpected, pMessage)
}

/// Assert Should Be Exact the same
Method Exactly(pValue, pExpected, pMessage = "")
{
	Do ..Is(pValue, pExpected, pMessage)
}

/// Assert given object matches a Regex<br/>
/// Given: String, otherValue: regexp. Uses %Regex.Matcher:
/// 
Method Regex(pValue, pRegex, pMessage = "")
{
	Set matcher = ##class(%Regex.Matcher).%New(pRegex)
	Set matcher.Text = pValue
	
    Set:pMessage="" pMessage = ..Message(pRegex,pValue)
    
	Do ..True(matcher.Locate(), pMessage)
}

Method Match(pValue, pRegex, pMessage = "")
{
	Do ..Regex(pValue, pRegex, pMessage)
}

/// Assert inclusive numeric range (<= to and >= from): <br/>
/// <br/>
/// Do ..Within(User.Age, 5, 50)
Method Within(pValue, pMin, pMax, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message(pMin_".."_pMax, pValue)
	Do ..True(((pValue >= pMin)&&(pValue <= pMax)),pMessage)
}

/// Above(num) and GreaterThan(num)
/// Assert numeric value above the given value (> num): <br/>
/// <br/>
/// Do ..Above(User.Age, 5)<br/>
/// Do ..GreaterThan(User.Age, 5)
Method Above(pValue, pNum, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message(pNum_" < ", pValue)
	Do ..True((pValue > pNum), pMessage)
}

/// Assert is greater than or equal to (>=) valueToBeAtLeast(num)
Method IsAtLeast(pValue, pNum, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Is at Least " _ pNum, pValue)
	Do ..True((pValue >= pNum), pMessage)
}

/// Assert numeric value above the given value (> num):
Method GreaterThan(pValue, pNum, pMessage = "")
{
	Do ..Above(pValue, pNum, pMessage = "")
}

/// Below(num) and LessThan(num)<br/>
/// Assert numeric value below the given value (< num)<br/>
/// <br/>
/// Do ..Below(User.Age, 50)<br/>
/// Do ..LessThan(User.Age, 50)
Method Below(pValue, pNum, pMessage = "")
{
	Do ..True((pValue < pNum), pMessage)
}

/// Assert numeric value below the given value (< num)
Method LessThan(pValue, pNum, pMessage = "")
{
	Do ..Below(pValue, pNum, pMessage = "")
}

/// Assert is less than or equal to (<=) valueToBeAtMost (num)
Method IsAtMost(pValue, pNum, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Is at Most " _ pNum, pValue)
	Do ..True((pValue <= pNum), pMessage)
}

/// Assert that a string starts with str.
/// <br/>
/// Do ..startWith('foobar','foo')
Method startWith(pValue, pExpected, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("start with "_pExpected, pValue)
	Set pExpected = $Replace($Replace($Replace($Replace(pExpected,"/","\/"),"+","\+"),"*","\*")," ","\s")
	Do ..Regex(pValue,"^("_pExpected_")",pMessage)
}

/// Assert floating point number near num within a +/- delta range.
/// <br/>
/// Do ..Approximately(3.49, 3.5, 0.01 )
Method Approximately(pValue As %Numeric, pExpected As %Numeric, pDelta As %Numeric = 0.01, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Approximately "_pExpected, pValue)
	Do ..Within(pValue, (pExpected - pDelta), (pExpected + pDelta), pMessage)
}

/// Asserts that the target is equal expected, to within a +/- delta range.
/// <br/>
/// Do ..CloseTo(1.5, 1, 0.5)
Method CloseTo(pValue As %Numeric, pExpected As %Numeric, pDelta As %Numeric = 0.5, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Close to "_pExpected, pValue)
	Do ..Approximately(pValue, pExpected, pDelta, pMessage)
}

/// Asserts that value is an object
Method IsObject(pValue, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Is Object")
	Do ..True($IsObject(pValue) , pMessage)
}

/// Asserts that value is NOT an object
Method IsNotObject(pValue, pMessage = "")
{
	Set:pMessage="" pMessage = ..Message("Is not Object", $ClassName(pValue))
	Do ..False($IsObject(pValue) , pMessage)
}

/// Assert that throws an error, or promise rejects with an error.
Method Throws(pStatus, pMessage = "")
{
	Do ..NotOk(pStatus)
}

/// Assert that doesn't throw an error or promise resolves
Method NotThrows(pStatus, pMessage = "")
{
	Do ..Ok(pStatus)
}

/// Asserts that value?s type is pClassName
/// <br/>
/// Do ..TypeOf(pClass, "%RegisteredObject" )
Method TypeOf(pValue, pClassName, pMessage = "")
{
	Do ..Is($ClassName(pValue),pClassName)
}

ClassMethod Pass(pMessage = "")
{
}

ClassMethod Fail(pMessage = "")
{
}

// TODO

Method AssertPropertyDefinition(ClassName As %String, PropertyName As %String, Definition As %String, Value)
{
	Set classDefinition = ##class(%Library.ClassDefinition).%OpenId(ClassName)
	Set properties = classDefinition.Properties
	
	Set foundProperty = ""
	For i=1:1:properties.Size
	{
		Set property = properties.GetAt(i)
		Set:property.Name=PropertyName foundProperty = property
	}
	
	If foundProperty
	{
		Set gotValue = $ZObjProperty(foundProperty, Definition)
		Do $$$AssertEquals(Value, gotValue, "Value was: "_gotValue)
	}
	Else
	{
		Do $$$AssertTrue(0, "Property does not exist: "_PropertyName)
	}
}

Method AssertMessageMapping(className As %String, type As %String, action As %String, index As %Integer = 1)
{
	Do ##class(Ens.Util.XML.Reader).ObjectsFromXData(.items, className, "MessageMap", "Ens.Config.MessageMap")
	If items="" {
		Do $$$AssertNotEquals("", items, "No mappings found")
	} ElseIf items.Size < index {
		Do $$$AssertTrue(items.Size >= index, "Could not find mapping for given index '"_index_"'")
	} Else {
		Do $$$AssertEquals(type, items.GetAt(index).MessageType)
		Do $$$AssertEquals(action, items.GetAt(index).ActionMethod)
	}
}
*/
Method Message(pExpected = "", pGot = "", pBR = "") As %String
{
	Set:pBR="" pBR = " "
	Quit "Expected: " _ $Get(pExpected) _ pBR _"Actual: "_$Get(pGot)
}

<Storage name="Default">
<Data name="AssertsState">
<Value name="1">
<Value>Number</Value>
</Value>
<Value name="2">
<Value>Ok</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Expectation</Value>
</Value>
<Value name="5">
<Value>Msg</Value>
</Value>
</Data>
<State>AssertsState</State>
<StreamLocation>^Pierogi.AssertsS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}

