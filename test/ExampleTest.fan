**
** Test class with the different type of results, expected and unexpected.
**  
class ExampleTest : Test 
{
  Void testShouldFail()
  {
    verifyEq(true, false, "This test should be a failure")
  }
    
  Void testShouldPass()
  {
    verifyEq(1, 1)
  }
  
  Void testShouldPass2()
  {
    verifyEq(1, 1)
  }
  
  Void testShouldErr()
  {
    throw Err("This test should be an error")
  }  
}
