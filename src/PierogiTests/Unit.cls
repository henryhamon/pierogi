Class PierogiTests.Unit
{

Parameter Package = "PierogiTests.Pierogi";

ClassMethod TempRoot() [ Private ]
{
	Quit "C:\"
}

ClassMethod Temp() [ Private ]
{
	Quit "temp\"
}

/// Abstract method that should return the temporary directory and filename 
/// to export the test package xml
/// Default value will be YearMonthDay_tests.xml
ClassMethod TempFileName() As %String [ Private ]
{
	Quit $ZDate($Horolog,8)_"_tests"
}

ClassMethod Export() [ Private ]
{
	Quit $System.OBJ.ExportPackage( ..#Package, ..TempRoot()_ ..Temp() _ ..TempFileName()_".xml")
}

ClassMethod Run(spec As %String = "")
{
	
	Set ^UnitTestRoot = ..TempRoot()
	Set tSC = ..Export()
	Quit:$$$ISERR(tSC) tSC
		
	Kill ^|$ZNSpace|UnitTestLog
	
	Set package = ..#Package
	
	Set suite = ..TempFileName() _":"_ package _spec 
	
	Quit ##class(%UnitTest.Manager).RunTest(..Temp(), "/noload/norecursive/nodelete")
}

}

