class TestSuiteTest : Test
{
  Void testMakeSuiteFromType()
  {
    suite := TestSuite(ExampleTest#)
    verify(suite.tests.size > 0)
    verifyEq(suite.name, ExampleTest#.name)
    verifyEq(suite.classname, ExampleTest#.qname)
  }
  
  Void testMakeSuiteWithAbstractClass()
  {
    verifyErr(ArgErr#)
    {
      suite := TestSuite(AbstractTest#)
    }
  }
  
  Void testMakeSuiteWithNoTestSubclass()
  {
    verifyErr(ArgErr#)
    {
      suite := TestSuite(Int#)
    }
  }
}
