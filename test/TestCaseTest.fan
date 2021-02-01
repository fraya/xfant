class TestCaseTest : Test 
{     
  Void testFromStr()
  {
    target := TestCase.fromStr("xfant::ExampleTest.testShouldPass")
    
    verifyEq(target.name, "testShouldPass")
    verifyEq(target.type, ExampleTest#)
  }
  
  Void testMake()
  {
    target := TestCase(ExampleTest#testShouldPass)
    verifyEq(target.name, "testShouldPass")
    verifyEq(target.classname, "xfant::ExampleTest")
  }    
  
  Void testMakeWithMethodDontStartWithTest()
  {
    verifyErr(ArgErr#)
    {
      target := TestCase(Str#.slot("capitalize"))
    }
  }
  
  Void testMakeWithMethodAbstract()
  {
    verifyErr(ArgErr#)
    {
      target := TestCase(AbstractTest#.slot("shouldBeAbstract"))
    }
  }  
}
