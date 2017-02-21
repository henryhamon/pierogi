Class Pierogi.Failures Extends %SerialObject
{

Property ClassName As %String;

Property SpecTest As %String;

Property Asserts As list Of Pierogi.Assert;

Method %OnNew(pClassName As %String = "", pSpecTest As %String = "", pFailAsserts As %ListOfObjects = "") As %Status [ Private, ServerOnly = 1 ]
{
	
	Set tSC = $$$OK
	Try {
		Set:pClassName'="" ..ClassName = pClassName
		Set:pSpecTest'="" ..SpecTest = pSpecTest
		I $ISO(pFailAsserts) {
			For k=1:1:pFailAsserts.Count() {
				Set assertFail = pFailAsserts.GetAt(k)
				$$$THROWONERROR(tSC, ..Asserts.Insert(assertFail))
			}
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
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

