Class Pierogi.Ensemble Extends (Pierogi.Ensemble.Core, Pierogi.Spec)
{

Property Time As %String;

Property Precision As %Integer [ InitialExpression = 6 ];

Method StartTimer()
{
	Set ..Time = $PIECE($Now(),",",2)
}

Method ShowCurrentTime(pDescription As %String, pStopTimer As %Boolean = 0)
{
	Write !," "_pDescription_" ",?60,$ZTIME($PIECE($Now(),",",2)- ..Time,1,..Precision),?79
	Do:pStopTimer ..StopTimer()
}

Method StopTimer()
{
	Set ..Time = $ZTIME($PIECE($Now(),",",2)-$PIECE($Now(),",",2),1,..Precision)
}

}

