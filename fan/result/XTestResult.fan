using xml

**
** Result of a a finished test. 
**
mixin XTestResult
{
  **
  ** Test executed
  **
  abstract Xtest test()
       
  **
  ** 'DateTime' when the test started
  **
  abstract DateTime started()
  
  **
  ** 'DateTime' when the test finished
  **
  abstract DateTime finished()
    
  **
  ** Time elapsed in the execution of the test.
  **
  Duration elapsed()
  {
    finished - started
  }
  
  **
  ** Result of the test in Xml
  **
  abstract XElem toXml()
}
