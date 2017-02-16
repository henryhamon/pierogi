Class SampleTest.Suite Extends Pierogi.Suite
{

/// Abstract method that should return the name of the package 
/// where the test cases are located.
ClassMethod SpecsPackage() As %String
{
	Quit "SampleTest"
}

/// Abstract method that should return the name of the package 
/// where the project classes are located.
ClassMethod ProjectPackage() As %String
{
	Quit "SamplePrj"
}

}

