Class Pierogi.TerminalDisplay
{

ClassMethod Cls()
{
	Write #,!,?2,"Baking Pierogies and Running Tests",!,*12,?4
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
	Write *27,"[31m","F",*27,"[0m"
}

ClassMethod Resume(pResults As Pierogi.Results)
{
	Write !,?4,*27,"[0m",	pResults.Tests(),	" tests",	*27,"[0m"
	Write !,?4,*27,"[32m",pResults.Pass,		" passed",	*27,"[0m"
	If pResults.Fail > 0 {
		Write *7 // Ring the Bell
		Write !,?4,*27,"[31m", pResults.Fail,	" failed",	*27,"[0m"
	} Else {
		Write !,?2,*27,"[32m","Pass!",	*27,"[0m"
	}
	Write !
}

ClassMethod FinishedIn(pDuration)
{
	Write !!,?2,*27,"[0m","Finished in ",pDuration," seconds",*27,"[0m",!
}

}

