using xml

**
** Report the test results as Xml.
**
class XmlReport : TestReport
{  
  **
  ** Test results to output
  **
  XTestResult[] results
  
  **
  ** Constructor
  **
  new make(XTestResult[] results := [,])
  {
    this.results = results
  }
  
  **
  ** Write an Xml document to 'out' stream.
  **
  override Void write(OutStream out)
  {
    doc   := XDoc { XElem("testsuites"), }
        
    results.each |r| 
    { 
      doc.root.add(r.toXml) 
    }
    
    doc.write(out)
  }
}
