using xml

**
** Summary of a group of test results. 
**
class TestSummary : XTestResult
{  
  **
  ** Test executed
  **
  override Xtest test
  
  **
  ** Tests collected results
  **
  XTestResult[] results
  
  **
  ** Timestamp when the test was executed
  **
  DateTime timestamp := DateTime.now
  
  **
  ** Hostname where the test was executed
  **
  Str hostname := Env.cur.host
  
  **
  ** Constructor
  **
  new make(|This| f)
  {
    f(this)
  }
    
  **
  ** Start time of the first test
  **
  override DateTime started()
  {
    results.first.started
  }
  
  **
  ** Finish time of the last test
  **
  override DateTime finished()
  {
    results.last.finished
  }
   
  **
  ** Frequency of tests by test type.
  **
  once Type:Int frequency()
  {
    res := Type:Int[:] { def = 0 }    
    results.each |test| { res[test.typeof] += 1 }    
    return res
  }
  
  **
  ** Total number of tests
  **
  Int total()
  {
    results.size
  }
  
  **
  ** Total number of tests that succeeded
  **
  Int successes()
  {
    frequency[TestSuccess#]
  }
  
  **
  ** Total number of tests that failed
  **
  Int failures()
  {
    frequency[TestFailure#]
  }
  
  **
  ** Total number of tests with errors
  **
  Int errors()
  {
    frequency[TestError#]
  }
  
  **
  ** Number of tests skipped
  **
  Int skipped()
  {
    frequency[TestSkipped#]
  }
  
  override XElem toXml()
  {
    xml := XElem("testsuite")
    {
      XAttr("name", test.name),
      XAttr("classname", test.classname),
      XAttr("package", test.pod),
      XAttr("hostname", hostname),
      XAttr("tests", total.toStr),
      XAttr("errors", errors.toStr),
      XAttr("failures", failures.toStr),
      XAttr("skipped", skipped.toStr),
      XAttr("time", elapsed.toSec.toStr),
      XAttr("timestamp", timestamp.toIso),
    }
    
    xml.add(propertiesToXml(Env.cur.vars))
    
    results.each |r| { xml.add(r.toXml) }
    
    return xml
  }
  
  **
  ** Convert environment variables to Xml
  **
  protected XElem propertiesToXml(Str:Str vars)
  {
    xml := XElem("properties")
    vars.keys.sort.each |k| { xml.add(propertyToXml(k, vars[k])) }
    return xml
  }
  
  **
  ** Convert a property to Xml
  **
  protected XElem propertyToXml(Str name, Str val)
  {
    XElem("property")
    {
      XAttr("name", name),
      XAttr("value", val),
    }
  }
}
