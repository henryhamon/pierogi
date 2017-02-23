Class Pierogi.TerminalDisplay
{

ClassMethod Cls()
{
	Write #,!,"Baking Pierogies and Running Tests",!,*12
}

ClassMethod Class(pClassName As %String)
{
	Write !,*27,"[0m",pClassName,*27,"[0m",!
}

ClassMethod Pass()
{
	Write *27,"[32m",".",*27,"[0m"
}

ClassMethod Fail()
{
	WRITE *7 // Ring the Bell
	Write *27,"[31m","F",*27,"[0m"
}

ClassMethod Resume()
{
}

ClassMethod FinishedIn(pDuration)
{
	Write !!,*27,"[0m","Finished in ",pDuration," seconds",*27,"[0m",!
}

}

