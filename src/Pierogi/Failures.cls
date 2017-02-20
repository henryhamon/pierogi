Class Pierogi.Failures Extends %SerialObject
{

Property ClassName As %String;

Property SpecTest As %String;

Property Asserts As list Of Pierogi.Assert;

Method %OnNew(pClassName As %String = "", pSpecTest As %String = "") As %Status [ Private, ServerOnly = 1 ]
{
	Set:pClassName'="" ..ClassName = pClassName
	Set:pSpecTest'="" ..SpecTest = pSpecTest
	Quit $$$OK
}

<Storage name="Default">
<Data name="FailuresState">
<Value name="1">
<Value>ClassName</Value>
</Value>
<Value name="2">
<Value>SpecTest</Value>
</Value>
<Value name="3">
<Value>Asserts</Value>
</Value>
</Data>
<State>FailuresState</State>
<StreamLocation>^Pierogi.FailuresS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}

