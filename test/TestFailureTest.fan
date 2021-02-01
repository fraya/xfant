using xml

class TestFailureTest : Test
{
  TestRunner? runner  
  Xtest? test  
  TestResult? result  
  XElem? xml
  
  override Void setup()
  {
    runner = TestRunner()
    test   = TestCase(ExampleTest#testShouldFail)
    result = runner.run(test)
    xml    = result.toXml
  }
  
  Void testShouldFail()
  {
    verifyType(result, TestFailure#)
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
    verifyEq(name.val, "testShouldFail")
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
  
  Void testXmlXElems()
  {  
    verifyEq(xml.elems.size, 1)
  }
   
  Void testXmlFailureXElem()
  {
    failure := xml.elems[0]
    
    verifyEq(failure.name, "failure")
    
    // test message attr
    
    message := failure.attr("message", false)
    
    verifyNotNull(message)
    verifyEq(message.name, "message")
    verifyEq(message.val, "Test failed: This test should be a failure")
    
    // test type attr
    
    type := failure.attr("type", false)
           
    verifyNotNull(type)
    verifyEq(type.name, "type")
    verifyEq(type.val, "TestErr")
    
    // test XText
    
    text := failure.text
    
    verifyNotNull(text)
    verifyType(text, XText#)
  }
}
