Class Pierogi.Results Extends %SerialObject
{

Property Pass As %Integer [ InitialExpression = 0 ];

Property Fail As %Integer [ InitialExpression = 0 ];

Property All As %ArrayOfDataTypes;

Property Status As %Status;

Method Tests() As %Integer
{
	Quit ..Pass + ..Fail
}

Method Add(pStatus As %String) As %Status
{
	Set tSC = $$$OK
	Try {
		Set:pStatus="fail" ..Fail = ..Fail + 1
		Set:pStatus="succeed" ..Pass = ..Pass + 1
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

<Storage name="Default">
<Data name="ResultsState">
<Value name="1">
<Value>All</Value>
</Value>
<Value name="2">
<Value>Pass</Value>
</Value>
<Value name="3">
<Value>Fail</Value>
</Value>
<Value name="4">
<Value>Test</Value>
</Value>
<Value name="5">
<Value>Status</Value>
</Value>
</Data>
<State>ResultsState</State>
<StreamLocation>^Pierogi.ResultsS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}

