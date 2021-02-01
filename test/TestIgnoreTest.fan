using xml

@Ignore
class TestSkippedClassTest : Test
{
  TestRunner? runner  
  Xtest? test  
  XTestResult? result  
  XElem? xml

  override Void setup()
  {
    runner = TestRunner()
    test   = TestCase(TestSkippedClassTest#testShouldSkip)
    result = runner.run(test)
    xml    = result.toXml
  }

  @Ignore
  Void testShouldSkip()
  {
    verifyTrue(true)
  }    
  
  Void testClassShouldBeIgnored()
  {
    test2 := TestSuite(TestSkippedClassTest#)
    res   := runner.run(test2)
    verifyType(res, TestSummary#)
    
    res2  := res as TestSummary
    
    verifyEq(res2.total, 1)
    verifyEq(res2.skipped, 1)
    verifyType(res2.results.first, TestSkipped#)
  }
}

class TestSkippedTest : Test
{
  TestRunner? runner  
  Xtest? test  
  TestResult? result  
  XElem? xml
  
  override Void setup()
  {
    runner = TestRunner()
    test   = TestCase(TestSkippedTest#testShouldSkip)
    result = runner.run(test)
    xml    = result.toXml
  }
  
  @Ignore
  Void testShouldSkip()
  {
    verifyTrue(true)
  }
  
  Void testShouldBeIgnored()
  {
    verifyType(result, TestSkipped#)
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
    verifyEq(name.val, "testShouldSkip")
  }
  
  Void testXmlClassnameAttr()
  {   
    classname := xml.attr("classname", false)
    
    verifyNotNull(classname)
    verifyEq(classname.name, "classname")
    verifyEq(classname.val, "xfant::TestSkippedTest")
  }
    
  Void testXmlTimeAttr()
  {   
    time := xml.attr("time", false)
    
    verifyNotNull(time)
    verifyEq(time.name, "time")
    verifyEq(time.val, "0")
  }    
  
  Void testXElem()
  {   
    verifyEq(xml.elems.size, 1)
    skip := xml.elems[0]
    
    verifyEq(skip.name, "skipped")
    
    // test attr
    
    verifyEq(skip.attrs.size, 0)
    
    // test XText
    
    verifyNull(skip.text)  
  }
}
