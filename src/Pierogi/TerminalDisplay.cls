Class Pierogi.TerminalDisplay
{

ClassMethod Cls()
{
	Write #,!,*12
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

ClassMethod Resume()
{
}

}

