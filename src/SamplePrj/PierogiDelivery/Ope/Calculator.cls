Class SamplePrj.PierogiDelivery.Ope.Calculator
{

/// Adds the given numbers together.
/// 
/// <example>
/// W ##class(SamplePrj.PierogiDelivery.Ope.Calculator).Add(1, 2)
/// ; 3
/// S FirstNumber = 1
/// Set SecondNumber = 10
/// Write ##class(SamplePrj.PierogiDelivery.Ope.Calculator).Add(FirstNumber, SecondNumber)
/// ; 11
/// </example>
/// 
/// Returns null if the given arguments don't add up nicely.
/// <example>
/// Write ##class(SamplePrj.PierogiDelivery.Ope.Calculator).Add("a", 42)
/// ; 
/// </example>
ClassMethod Add(pN1, pN2) As %Integer
{
	Set tResp = ""
	Set:((pN1?.N.1".".N)&&(pN2?.N.1".".N)) tResp = pN1 + pN2
	Quit tResp
}

/// Multiplies the given numbers together.
/// This example should be fail...
/// <example>
/// S FirstNumber = 1
/// Set SecondNumber = 10
/// Write ##class(SamplePrj.PierogiDelivery.Ope.Calculator).Multiply(FirstNumber, SecondNumber)
/// ; 10
/// </example>
ClassMethod Multiply(pN1, pN2) As %Integer
{
	Q pN1 + pN2
}

/// This example should generate an Exception,<br>
/// because the method is calling without "." (dot) <br>
/// On Example code:
/// <example>
/// Write ##class(SamplePrj.PierogiDelivery.Ope.Calculator)Exception(FirstNumber, SecondNumber)
/// ; 10
/// </example>
ClassMethod Exception() As %Status
{
	Quit $$$ERROR(5002,"Exception")
}

}

