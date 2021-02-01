using xml

class TestSuccessTest : Test
{
  TestRunner? runner  
  Xtest? test  
  XTestResult? result  
  XElem? xml
  
  override Void setup()
  {
    runner = TestRunner()
    test   = TestCase(xfant::ExampleTest#testShouldPass)
    result = runner.run(test)
    xml    = result.toXml
  }
  
  Void testShouldPass()
  {
    verifyType(result, TestSuccess#)
  }
  
  Void testShouldPass2()
  {
    t2   := TestCase(xfant::ExampleTest#testShouldPass2)
    res2 := runner.run(t2)
    
    verifyType(res2, TestSuccess#)
  }
  
  Void testXml()
  {
    verifyEq(xml.name, "testcase")
  }

  Void testXmlNameAttr()
  {  
    name := xml.attr("name", false)
    
    verifyNotNull(name)
    verifyEq(name.name, "name")
    verifyEq(name.val, "testShouldPass")
  }
  
  Void testXmlClassnameAttr()
  {   
    classname := xml.attr("classname", false)
    
    verifyNotNull(classname)
    verifyEq(classname.name, "classname")
    verifyEq(classname.val, "xfant::ExampleTest")
  }
  
  Void testXmlTimeAttr()
  {   
    time := xml.attr("time", false)
    
    verifyNotNull(time)
    verifyEq(time.name, "time")
    verifyEq(time.val, "0")
  }
}
