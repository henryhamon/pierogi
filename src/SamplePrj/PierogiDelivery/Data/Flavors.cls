/// This class contain a Pierogi DocTest Sample
Class SamplePrj.PierogiDelivery.Data.Flavors Extends %Persistent
{

Property Name As %String;

Property Price As %Numeric;

Index FindName On Name [ Unique ];

Relationship Meals As SamplePrj.PierogiDelivery.Data.Order [ Cardinality = many, Inverse = Pierogis ];

/// Populating the Database with seeds. <br>
/// The method Seeds is a way of feeding default values easily and quickly to a fresh installation.<br>
/// <p>
/// Examples:
/// <p>
/// <pre>
/// 		>> Do ##class(SamplePrj.PierogiDelivery.Data.Flavors).Seeds()
/// 		>> Set flavor = ##class(SamplePrj.PierogiDelivery.Data.Flavors).%OpenId(1)
/// 		>> Write flavor.Name 
/// 		Duck & Pears
/// </pre>
/// <br>
ClassMethod Seeds() As %Status
{
	Set tSC = $$$OK
	Try {
		$$$THROWONERROR(tSC, ..%KillExtent())
		Set Flavors = $ListFromString("Duck & Pears;Sweet Potato;Savory Chuck Roast;Sauerkraut & Onion;Potato with Onion;Potato with Jalapeno Cheese;Ricotta with Spinach & Roasted Garlic;Farmer's Cheese with Onion & Chives;Buffalo Chicken;Cheesy & Spinach;Farmer's Cheese;Garlic, Smashed Potato;Potato & Cheddar;Potato, Cheddar & Bacon;Pulled Pork;Sauerkraut;Sauerkraut & Mushroom;Plum;Smoked, Ham, Sausage and Cheese;Mushroom;Bolognese;Smoked, chicken & Cheese;Chilli & Cheese;Sweet Cheese;Ruskie;Blueberries;Apples;Meat & Cheese;Bryndza Cheese;Schlutzkrapfen;Bacon",";")
		
		For k=1:1:$ListLength(Flavors){
			$$$THROWONERROR(tSC, ..%New($List(Flavors,k), ##class(cosFaker.Finance).Amount(3,14,,".")).%Save())
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

/// Create an object when pass parameters <br>
/// <example>
/// Do ##class(SamplePrj.PierogiDelivery.Data.Clients).%KillExtent()
/// Set flavor = ##class(SamplePrj.PierogiDelivery.Data.Flavors).%New("Pineapple",10)
/// Do flavor.%Save()
/// Write flavor.Price
/// ; 10
/// </example>
Method %OnNew(pFlavorName As %String, pPrice As %Numeric) As %Status [ Private, ServerOnly = 1 ]
{
	Set ..Name = pFlavorName,
		..Price = pPrice
	Quit $$$OK
}

<Storage name="Default">
<Data name="FlavorsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Price</Value>
</Value>
</Data>
<DataLocation>^SamplePrj.Pierogi5322.FlavorsD</DataLocation>
<DefaultData>FlavorsDefaultData</DefaultData>
<IdLocation>^SamplePrj.Pierogi5322.FlavorsD</IdLocation>
<IndexLocation>^SamplePrj.Pierogi5322.FlavorsI</IndexLocation>
<SequenceNumber>7</SequenceNumber>
<StreamLocation>^SamplePrj.Pierogi5322.FlavorsS</StreamLocation>
<Type>%Library.CacheStorage</Type>
</Storage>
}

