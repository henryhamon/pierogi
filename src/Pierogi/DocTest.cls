Class Pierogi.DocTest
{

ClassMethod Run(pProjectPackage As %String, ByRef pResults As Pierogi.Results = "") As %Status
{
	Set tSC = $$$OK
	Set:pResults="" pResults = ##class(Pierogi.Results).%New()
	Try {
		
		Set tSql = "Select Parent As Class, Name As Method, Description As Block "_
			" FROM %Dictionary.MethodDefinition "_
			" Where parent %StartsWith ? " _
			"   And Abstract = 0 " _
			"   And (Description like '%Examples%' OR Description like '%<example>%') "_
			" Order by SequenceNumber ",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		Set tRS = tStatement.execute(pProjectPackage)
		
		While tRS.%Next() {
			$$$THROWONERROR(tSC, ..ParseAndExecute(tRS.%Get("Class"), tRS.%Get("Method"), tRS.%Get("Block"), .pResults ))
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod ParseAndExecute(pClass As %String, pMethod As %String, pBlock As %String, ByRef pResults As Pierogi.Results) As %Status [ Internal ]
{
	Set tSC = $$$OK
	Try {
		Set asserts = ##class(%ListOfObjects).%New(), 
			failures = ##class(%ListOfObjects).%New(),
			bFail = $$$NO
		$$$THROWONERROR(tSC, ..GetCodeBlock(pBlock, .Code))
		
		For k=1:1:$ListLength(Code){
			Set value = $List(Code,k)
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
					Set action = "InternalDocTest2 = " _ $Extract(value,action,*)
					Set @action
					Set action = "InternalDocTest2"
					Set InternalDocTest = @action
					
					Set tResult =$Replace($Replace($List(Code,k+1),$Char(9),""),"; ",""), 
						tExpect = $Get(InternalDocTest)
					Set tMessage = ##class(Pierogi.Assertions).Message(tExpect, tResult)
					
					Set assert = ##class(Pierogi.Assert).Satisfy(asserts.Count(), "", tExpect = tResult, tMessage)
					$$$THROWONERROR(tSC, asserts.Insert(assert))
					If assert.Ok=$$$NO {
						Set bFail=$$$YES
						$$$THROWONERROR(tSC, failures.Insert(assert))
					}
					
					Kill InternalDocTest, InternalDocTest2
				}
			}
		}
			
		If bFail {
			Set pResults.Status = "fail"
			Set pResults.Fail = pResults.Fail + 1
			$$$THROWONERROR(tSC, pResults.Failures.Insert(##class(Pierogi.Failures).%New(pClass, pMethod, failures)))
		} Else {
			Set pResults.Pass = pResults.Pass + 1
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
		
		Set pResults.Status = "fail",
			tDescError = $System.Status.GetErrorText(tSC), 
			pResults.Fail = pResults.Fail + 1,
			failure = ##class(Pierogi.Failures).%New(pClass, pMethod) 
			
		Do failure.Asserts.Insert(##class(Pierogi.Assert).Satisfy(0, "", 0, tDescError)),
			pResults.Failures.Insert(failure)
			
		// If got an error, report it and keep going
		Set tSC = $$$OK
	}
	Quit tSC
}

ClassMethod GetCodeBlock(pBlock As %String, Output pCodeBlock) As %Status [ Private ]
{
	Set tSC = $$$OK, pCodeBlock = ""
	Try {
		
		Set block = $ListFromString(pBlock,$Char(13,10)),
			pre = $$$NO
			
		For k=1:1:$ListLength(block) {
			Set value = $List(block,k)
			
			Set:($Find(value,"<pre>")||$Find(value,"<example>")) pre = $$$YES
			Set:($Find(value,"</pre>")||$Find(value,"</example>")) pre = $$$NO
			
			Set:pre=$$$YES $List(pCodeBlock, *+1) = value
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

