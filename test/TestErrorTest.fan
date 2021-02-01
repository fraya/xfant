using xml

class TestErrorTest : Test
{
  TestRunner? runner  
  Xtest? test  
  XTestResult? result  
  XElem? xml
  
  override Void setup()
  {
    runner = TestRunner()
    test   = TestCase(ExampleTest#testShouldErr)
    result = runner.run(test)
    xml    = result.toXml
  }
  
  Void testShouldBeAnTestErr()
  {
    verifyType(result, TestError#)
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
    verifyEq(name.val, "testShouldErr")
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
   
  Void testXmlErrXElem()
  {
    err := xml.elems[0]
    
    verifyEq(err.name, "error")
    
    // test message attr
    
    message := err.attr("message", false)
    
    verifyNotNull(message)
    verifyEq(message.name, "message")
    verifyEq(message.val, "This test should be an error")
    
    // test type attr
    
    type := err.attr("type", false)
           
    verifyNotNull(type)
    verifyEq(type.name, "type")
    verifyEq(type.val, "Err")
    
    // test XText
    
    text := err.text
    
    verifyNotNull(text)
    verifyType(text, XText#)
  }
}
