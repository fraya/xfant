using xml

class TestSummaryTest : Test
{
  TestRunner? runner
  Xtest? test
  TestSummary? summary
  XElem? xml
  
  override Void setup()
  {
    runner  = TestRunner()
    test    = TestSuite(ExampleTest#)
    summary = runner.run(test) as TestSummary
    xml     = summary.toXml
  }  
    
  Void testTotal()
  {
    verifyEq(summary.total, 4)
  }
  
  Void testSuccesses()
  {
    verifyEq(summary.successes, 2)
  }
  
  Void testFailures()
  {
    verifyEq(summary.failures, 1)
  }
  
  Void testErrors()
  {
    verifyEq(summary.errors, 1)
  }
  
  Void testXElem()
  {
    verifyEq(xml.name, "testsuite")
  }
  
  Void testXAttrName()
  {
    name := xml.attr("name", false)
    verifyNotNull(name)
    verifyEq(name.name, "name")
    verifyEq(name.val, "ExampleTest")
  }
   
  Void testXAttrClassname()
  {
    classname := xml.attr("classname", false)
    verifyNotNull(classname)
    verifyEq(classname.name, "classname")
    verifyEq(classname.val, "xfant::ExampleTest")
  }
  
  Void testXAttrPackage()
  {
    attr := xml.attr("package", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "package")
    verifyEq(attr.val, "xfant")
  }  
  
  Void testXAttrHostname()
  {
    hostname := xml.attr("hostname", false)
    verifyNotNull(hostname)
    verifyEq(hostname.name, "hostname")
  }
  
  Void testXAttrTime()
  {
    attr := xml.attr("time", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "time")
  }
  
  Void testXAttrTimestamp()
  {
    attr := xml.attr("timestamp", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "timestamp")
  }
  
  Void testXAttrTests()
  {
    tests := xml.attr("tests", false)
    verifyNotNull(tests)
    verifyEq(tests.name, "tests")
    verifyEq(tests.val, "4")
  }
  
  Void testXAttrErrors()
  {
    attr := xml.attr("errors", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "errors")
    verifyEq(attr.val, "1")
  }
  
  Void testXAttrFailures()
  {
    attr := xml.attr("failures", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "failures")
    verifyEq(attr.val, "1")
  } 
  
  Void testXAttrSkipped()
  {
    attr := xml.attr("skipped", false)
    verifyNotNull(attr)
    verifyEq(attr.name, "skipped")
    verifyEq(attr.val, "0")
  }
}
