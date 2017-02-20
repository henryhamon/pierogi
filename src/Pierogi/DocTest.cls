Class Pierogi.DocTest
{

Property Project As %String;

Method GetDocCodes() As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		
		Set tSql = "Select Parent As Class, Name As Method, Description As Block "_
			" FROM %Dictionary.MethodDefinition "_
			" Where parent %StartsWith ? " _
			"   And Abstract = 0 " _
			"   And (Description like '%Examples%' OR Description like '%<example>%') "_
			" Order by SequenceNumber ",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		Set tRS = tStatement.execute(..Project)
		
		While tRS.%Next() {
			$$$THROWONERROR(tSC, ..ParseAndExecute(tRS.%Get("Class"), tRS.%Get("Method"), tRS.%Get("Block") ))
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method ParseAndExecute(pClass As %String, pMethod As %String, pBlock As %String) As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		For k=1:1:$ListLength(pBlock) {
			Set value = $List(pBlock,k)
			
			Set:($Find(value,"<pre>")||$Find(value,"<example>")) pre = $$$YES
			Set:($Find(value,"</pre>")||$Find(value,"</example>")) pre = $$$NO
			
			Set:pre=$$$YES $List(doctest, *+1) = value
		}
		
		For k=1:1:$ListLength(doctest){
			Set value = $List(doctest,k)
			If (($Find(value,">> ")) || ('$Find(value,"; "))){
				Set value = $Replace(value,">> ","")
				
				// Do
				Set action = $FIND($ZConvert(value,"U"),"DO ")
				Set:action=0 action = $FIND($ZConvert(value,"U"),"D ",0)
				If action>0 {
					Set action = $Extract(value,action,*)
					Do @action
				}
				
				// Set
				Set action = $FIND($ZConvert(value,"U"),"SET ")
				Set:action=0 action = $FIND($ZConvert(value,"U"),"S ",0)
				If action>0 {
					Set action = $Extract(value,action,*)
					Set @action
				}
				
				// Write
				Set action = $FIND($ZConvert(value,"U"),"WRITE ")
				Set:action=0 action = $FIND($ZConvert(value,"U"),"W ",0)
				If action>0 {
					Set action = "ac2 = " _ $Extract(value,action,*)
					Set @action
					Set action = "ac2"
					Set ac3 = @action
					Write !,$Get(ac3)," - ",$Replace($Replace($List(doctest,k+1),$Char(9),""),"; ",""),!
				}
			}
		}
			
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

