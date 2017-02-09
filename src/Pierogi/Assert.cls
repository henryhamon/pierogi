Class Pierogi.Assert Extends %SerialObject
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

Method %OnNew(pLastNumber As %Integer = 0) As %Status [ Private, ServerOnly = 1 ]
{
	Set ..Number = $Increment(pLastNumber)
	Quit $$$OK
}

<Storage name="Default">
<Data name="AssertState">
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
<Value>Msg</Value>
</Value>
<Value name="5">
<Value>Expectation</Value>
</Value>
</Data>
<State>AssertState</State>
<StreamLocation>^Pierogi.AssertS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}
