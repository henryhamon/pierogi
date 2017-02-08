Class Pierogi.Suite Extends %RegisteredObject [ Abstract ]
{

/// Abstract method that should return the name of the package 
/// where the test cases are located.
ClassMethod Package() As %String [ Abstract ]
{
}

/// Returns a list of test cases based on what is returned
/// from the <method>Package</method> class method.
ClassMethod Tests()
{
	Do $system.OBJ.GetPackageList(.classList, ..Package())
	Set class = ""
	Set testList = ""
	
	For
	{
		Set class = $Order(classList(class))
		Quit:class=""
		
		If $$issubclassof^%occCompile(class,"%UnitTest.TestCase")
		   && '##class(%Dictionary.ClassDefinition).%OpenId(class).Abstract
		{
			If testList = ""
			{
				Set testList = class
			}
			Else
			{
				Set testList = testList_","_class
			}
		}	
	}
	
	Quit $ListFromString(testList)
}

}

