**
** Creates a test for a method.
**
** The method must:
**   - have a name that starts with "test",
**   - not be abstract.
**
const class TestCase : Xtest
{  
  **
  ** Matches 'pattern' with 'pod::type.slot'. 
  ** If matches, returns the 'Slot', if the string is invalid 
  ** returns an error if 'checked' is 'true' or 'null' otherwise.
  ** 
  static new fromStr(Str pattern, Bool checked := true)
  {
    try
    {
      matcher := re.matcher(pattern)      
      
      if (!matcher.matches)
      {
        throw ArgErr("Expected 'pod::type.slot' but got: '${pattern}'")
      }
            
      pod  := Pod.find(matcher.group(1))
      type := pod.type(matcher.group(2))
      slot := type.slot(matcher.group(3))
      
      return make(slot)
    }
    catch (Err e)
    {
      if (checked)
      {
        throw e
      }
      else
      {
        return null
      }
    }
  }
  
  **
  ** Constructor
  **
  new make(Method method)
  {
    checkMethodName(method)
    checkMethodIsNotAbstract(method)    
    this.method = method
  }
  
  protected Void checkMethodName(Method method)
  {
    if (!method.name.startsWith("test"))
    {
      throw ArgErr("Test method name '${method.name}' must start with 'test'")
    }
  }

  protected Void checkMethodIsNotAbstract(Method method)
  {
    if (method.isAbstract)
    {
      throw ArgErr("Test method mustn't be abstract")
    }
  }
  
  **
  ** The name of the test
  **
  override Str name()
  {
    method.name
  }
 
  **
  ** Type of the class where the method belongs
  ** 
  Type type()
  {
    method.parent
  }
  
  **
  ** The classname of wich this test belongs.
  **
  override Str classname()
  {
    type.qname
  }
  
  **
  ** Package/pod name
  **
  override Str pod()
  {
    type.pod.name
  }
  
  **
  ** Create the 'Test' instance specified by 'type'
  **
  Test makeTest()
  {
    (Test) type.make
  }

  **
  ** Calls 'method' on the 'test' instance and returns result
  **
  Obj? call(Test test)
  {
    method.callOn(test, null)
  }
  
  Bool isIgnored()
  {
    method.hasFacet(Ignore#)
  }
  
  **
  ** Name of the test.
  **
  override Str toStr()
  {
    name
  }
    
  **
  ** Method to test
  **
  const Method method
  
  **
  ** Regex to parse a 'pod::type.slot' pattern.
  **
  const static Regex re := "(\\w+)[:]{2}(\\w+)[.]{1}(\\w+)".toRegex
}
