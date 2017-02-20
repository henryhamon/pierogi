/// Memento Class
Class Pierogi.Results Extends %SerialObject
{

Property Pass As %Integer [ InitialExpression = 0 ];

Property Fail As %Integer [ InitialExpression = 0 ];

Property Failures As list Of Pierogi.Failures;

Property Status As %Status;

Method Tests() As %Integer
{
	Quit ..Pass + ..Fail
}

Method Add(pClass, pSpec As %String = "") As %Status
{
	Set tSC = $$$OK
	Try {
		Set:pClass.Status="succeed" ..Pass = ..Pass + 1
		If pClass.Status="fail" {
			Set ..Fail = ..Fail + 1
			Set failure = ##class(Pierogi.Failures).%New($ClassName(pClass), pSpec)
			For k=1:1:pClass.Fails.Count() {
				Set assertFail = pClass.Fails.GetAt(k)
				$$$THROWONERROR(tSC, failure.Asserts.Insert(assertFail))
			}
			$$$THROWONERROR(tSC, ..Failures.Insert(failure))
		}
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
<Value name="6">
<Value>Failures</Value>
</Value>
</Data>
<State>ResultsState</State>
<StreamLocation>^Pierogi.ResultsS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}

