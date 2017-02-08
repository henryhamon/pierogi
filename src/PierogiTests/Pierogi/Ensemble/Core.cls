Class PierogiTests.Pierogi.Ensemble.Core Extends (%UnitTest.TestCase, PierogiTests.Pierogi.Helper)
{

Method OnBeforeAllTests() As %Status
{
	Set tSC = $$$OK
	Try {
		Do ##class(SamplePrj.PierogiDelivery.Data.Order).%KillExtent()
		Do ##class(SamplePrj.PierogiDelivery.Data.Clients).%KillExtent()
		Do ##class(SamplePrj.PierogiDelivery.Data.Flavors).%KillExtent()
		Do ##class(SamplePrj.PierogiDelivery.Data.Clients).Populate(10)
		Do ##class(SamplePrj.PierogiDelivery.Data.Flavors).Seeds()
		
		OPEN 1
		USE 1
			Do ##class(Ens.Director).StopProduction()
			Do ##class(Ens.Director).StartProduction()
		CLOSE 1
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method OnAfterAllTests() As %Status
{
	OPEN 1
	USE 1
		Do ##class(Ens.Director).StopProduction()
	CLOSE 1
	Quit $$$OK
}

// Auxiliary -------------------------------------------------------------------------------------------

ClassMethod ClientsList() As %String
{
	Set tOutput = ""
	Try {
		
		Set tSql = "Select ID as Client FROM SamplePrj_PierogiDelivery_Data.Clients ",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		
		Set tRS = tStatement.execute()
		
		While tRS.%Next() {
			Set $List(tOutput, *+1) = tRS.%Get("Client")
		}
		
		Set tOutput = $ListToString(tOutput,",")
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tOutput
}

ClassMethod FlavorList() As %String
{
	Set tOutput = ""
	Try {
		
		Set tSql = "Select Name As Flavor FROM SamplePrj_PierogiDelivery_Data.Flavors ",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		
		Set tRS = tStatement.execute()
		
		While tRS.%Next() {
			Set $List(tOutput, *+1) = tRS.%Get("Flavor")
		}
		
		Set tOutput = $ListToString(tOutput,",")
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tOutput
}

// Factories --------------------------------------------------------------------------------------------

ClassMethod ServiceOrderFactory(Output pClient As SamplePrj.PierogiDelivery.Data.Clients = "", Output pFlavor = "") As SamplePrj.PierogiDelivery.Service.Order.Req
{
	Set tfactory = ##class(SamplePrj.PierogiDelivery.Service.Order.Req).%New()
	
	Set tClients = $ListFromString(..ClientsList(),",")
	Set randomClient = ##class(SamplePrj.PierogiDelivery.Data.Clients).%OpenId($List(tClients, $Random($ListLength(tClients)) + 1))
	
	Set tFlavors = $ListFromString(..FlavorList(),",")
	Set randomFlavor = $List(tFlavors, $Random($ListLength(tFlavors)) + 1)
	
	Set tfactory.ClientCity 	= randomClient.City,
		tfactory.ClientName 	= randomClient.Name, 
		tfactory.ClientStreet 	= randomClient.Street, 
		tfactory.PierogiFlavor	= randomFlavor,
		tfactory.Quantity		= $Random(999)
		
	Set pClient = randomClient
	Set pFlavor = randomFlavor
	
	Quit tfactory
}

// Tests Specs ------------------------------------------------------------------------------------------

Method TestGetRunTimeInfo()
{
	Do ..ItShouldBeOk(##class(Pierogi.Ensemble.Core).RunTimeInfo("bsOrder",.tConfigName,.tClassName))
	Do ..ItShouldBeEqual(tConfigName,"bsOrder")
	Do ..ItShouldBeEqual(tClassName,"SamplePrj.PierogiDelivery.Service.Order")
}

Method TestInvalidEnsembleObject()
{
	Do ..ItShouldBeOk(##class(Pierogi.Ensemble.Core).RunTimeInfo("businessServiceInvalidName",.tConfigName,.tClassName))
	Do ..ItShouldBeEqual(tConfigName,"")
	Do ..ItShouldBeEqual(tClassName,"")
}

Method TestIfIsABusinessService()
{
	Do ..ItShouldBeTrue(##class(Pierogi.Ensemble.Core).IsAService("SamplePrj.PierogiDelivery.Service.Order"))
	Do ..ItShouldBeFalse(##class(Pierogi.Ensemble.Core).IsAService("SamplePrj.PierogiDelivery.Service.Invalid"))
	Do ..ItShouldBeFalse(##class(Pierogi.Ensemble.Core).IsAService("SamplePrj.PierogiDelivery.Operation.Client"))
}

Method TestCallBusinessService()
{
	Set tClients = $ListFromString(..ClientsList(),","),
		randomClient = ##class(SamplePrj.PierogiDelivery.Data.Clients).%OpenId($List(tClients, $Random($ListLength(tClients)) + 1)),
		request = ##class(SamplePrj.PierogiDelivery.Service.Client.Req).%New(),
		request.Name 	= randomClient.Name,
		request.City 	= randomClient.City,
		request.Street 	= randomClient.Street
		
	Do ..ItShouldBeOk(##class(Pierogi.Ensemble.Core).Call("bsClient", request, .response))
			
	Do ..ItShouldBeTrue($IsObject(response))
	Do ..ItShouldBeEqual(response.ClientId, randomClient.%Id())
}

Method TestCallBusinessOperation()
{
	Set tClients = $ListFromString(..ClientsList(),","),
		randomClient = ##class(SamplePrj.PierogiDelivery.Data.Clients).%OpenId($List(tClients, $Random($ListLength(tClients)) + 1)),
		request = ##class(SamplePrj.PierogiDelivery.Operation.Client.Req).%New(),
		request.Name 	= randomClient.Name,
		request.City 	= randomClient.City,
		request.Street 	= randomClient.Street
	
	Do ..ItShouldBeOk(##class(Pierogi.Ensemble.Core).Call("boClient", request, .response))
	
	#Dim response As SamplePrj.PierogiDelivery.Operation.Client.Resp
	Do ..ItShouldBeEqual(response.ClientId,randomClient.%Id())
}

}

