Class Pierogi.Spec Extends Pierogi.Expectations
{

Property Method As %String [ Private ];

Property Description As %String [ Private ];

Method Describe(pContent As %String = "") As %String
{
	Set ..Description = pContent
	Quit pContent
}

Method BeforeSetup()
{
}

Method Before()
{
}

Method After()
{
}

Method AfterTeardown()
{
}

}

