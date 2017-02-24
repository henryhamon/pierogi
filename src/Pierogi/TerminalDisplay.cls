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
		// Write !!,?2,*27,"[31m", ..KeepingDoing(),	*27,"[0m",!
		Do ..ShowFailures(pResults)
	} Else {
		Write !,?2,*27,"[32m","Pass!", ..WellDone(),	*27,"[0m"
	}
	Write !
}

ClassMethod ShowFailures(pResults As Pierogi.Results)
{
	Set red = "[31m"
	Write !,?1,"=>",*27,"[33m", " Failed Tests: ",	*27,"[0m"
	Write *27,"[0m"," There were ",	*27,"[0m"
	Write *27,red, pResults.Failures.Count(),*27,"[0m"
	Write *27,"[0m"," failures.",*27,"[0m",!
	
	S lastClass = ""
	
	While pResults.Failures.GetNext(.key) {
		Set failure = pResults.Failures.GetAt(key)
		#Dim failure as Pierogi.Failures
		
		If lastClass '= failure.ClassName {
			Set lastClass = failure.ClassName
			Write !!,?1,lastClass
		}
		
		Write !,?3,key,") ",failure.Describe()
		
		While failure.Asserts.GetNext(.assert) {
			If failure.Asserts.GetAt(assert).Name'="" {
				Set assertDesc = "["_failure.Asserts.GetAt(assert).Number _"] "_
					failure.Asserts.GetAt(assert).Msg
			} Else {
				Set assertDesc = failure.Asserts.GetAt(assert).Msg
			}
			Write:assertDesc'="" !,?6,*27,red,assertDesc,	*27,"[0m"
		}
	}
}

ClassMethod FinishedIn(pDuration)
{
	Write !!,?2,*27,"[0m","Finished in ",pDuration," seconds",*27,"[0m",!
}

ClassMethod WellDone()
{
	Set $List(quote, *+1)= " Great Job :)"
	Set $List(quote, *+1)= " Have a Nice Day :D"
	Set $List(quote, *+1)= " Do, or do not. There is no try. "_$Char(10,13)_
							"  - Yoda"
	Set $List(quote, *+1)= " We?re going to change the game."
	Set $List(quote, *+1)= " A lot of people failed at what you accomplished,"_$Char(10,13)_
							"   simply because they were busy finding problems"_$Char(10,13)_
							"   while you were busy finding solutions. "_$Char(10,13)_
							"  Well done."
	Set $List(quote, *+1)= " Better a little which is well done, than a great deal imperfectly."
	Set $List(quote, *+1)= " Well done."
	Set $List(quote, *+1)= " Doing anything with perfection is like wearing an impeccable suit "_$Char(10,13)_
							"  ? the best way to make a great impression. "_$Char(10,13)_
							"  Well done."
	Set $List(quote, *+1)= " May success follow you, each and every place you go. In the halo of prosperity, may you always glow. May you get everything, that you could ever ask for. Great times lie ahead for you, of that we are very sure. Well done."
	Set $List(quote, *+1)= " One job well done can be redemption for many a mistake of the past."_$Char(10,13)_
							"  Keep it up."
	Set $List(quote, *+1)= " The tipping point between a boy and a man is a job well done. "_$Char(10,13)_
							"  Congratulations."
	Set $List(quote, *+1)= " I always knew you that you have what it takes to be a real winner. "_$Char(10,13)_
							"  Thanks for a great job."
	Set $List(quote, *+1)= " Don't stop when you are tired. Stop when you are done!"
	Set $List(quote, *+1)= " I always knew you that you have what it takes to be a real winner. "_$Char(10,13)_
							"  Thanks for a great job."
	Set $List(quote, *+1)= " I knew the rest of our journey would be great success. "_$Char(10,13)_
							"  -Borat Sagdiyev"
	Set $List(quote, *+1)= " Great success! "
	 
	Quit $List(quote,$Random($ListLength(quote))+1)
}

ClassMethod KeepingDoing()
{
	Set $List(quote, *+1)= " Just keep swimming. "_$Char(10,13)_
							"  -Dori"
	Set $List(quote, *+1)= " If you're going through hell, keep going. "_$Char(10,13)_
							"  -Winston Churchill "
	Set $List(quote, *+1)= " You have to keep going and pursue your dreams. "_$Char(10,13)_
							"  -Joey King"
	Set $List(quote, *+1)= " Never gonna give you up, never gonna let you down."_$Char(10,13)_
							"   Never gonna run around and desert you."_$Char(10,13)_
							"   Never gonna make you cry, never gonna say goodbye."_$Char(10,13)_
							"   Never gonna tell a lie and hurt you "_$Char(10,13)_
							"  -Rick Astley"
	Set $List(quote, *+1)= " I know it hurt's but stay strong!"
	Set $List(quote, *+1)= " Remember why you started. Don't give up, find a way."
	Set $List(quote, *+1)= " Never give up. Today is hard, tomorrow will be worse,"_$Char(10,13)_
							"   but the day after tomorrow will be sunshine. "_$Char(10,13)_
							"  -Jack Ma"
	Set $List(quote, *+1)= " Never gonna give you up, never gonna let you down."_$Char(10,13)_
							"   Never gonna run around and desert you."_$Char(10,13)_
							"   Never gonna make you cry, never gonna say goodbye."_$Char(10,13)_
							"   Never gonna tell a lie and hurt you "_$Char(10,13)_
							"  -Rick Astley"
	Set $List(quote, *+1)= " Never give up, have the passion. Don't be afraid. "_$Char(10,13)_
							"  -Barbara Broccoli"
	Set $List(quote, *+1)= " Never, never, never give up. "_$Char(10,13)_
							"  -Winston Churchill"
	Set $List(quote, *+1)= " Ha ha! "_$Char(10,13)_
							"  -Nelson Muntz"
	
	Quit $List(quote,$Random($ListLength(quote))+1)
}

ClassMethod FailColor() [ Private ]
{
	Quit "[31m"
}

ClassMethod PassColor() [ Private ]
{
	Quit "[31m"
}

}

