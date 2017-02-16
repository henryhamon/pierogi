Class SampleTest.spec01 Extends Pierogi.Spec
{

ClassMethod CreateClient()
{
	Set client = ##class(SamplePrj.PierogiDelivery.Data.Clients).%New()
	Set client.Name = ##class(%PopulateUtils).Name()
	Set client.City = ##class(%PopulateUtils).City()
	Set client.Street = ##class(%PopulateUtils).Street()
	Do client.%Save()
}

Method BeforeSetup()
{
	Do ##class(SamplePrj.PierogiDelivery.Data.Clients).%KillExtent()
}

Method Before()
{
	For k=1:1:2 {
		Do ..CreateClient()
	}
}

Method After()
{
	Do ..CreateClient()
}

Method AfterSetup()
{
	Do ##class(SamplePrj.PierogiDelivery.Data.Clients).%KillExtent()
}

Method ShouldTestOne()
{
	Do ..Ok($$$OK)
}

Method ShouldFail()
{
	Do ..NotOk($$$OK)
}

}

