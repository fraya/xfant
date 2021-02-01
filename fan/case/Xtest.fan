**
** Interface for a test case to execute.
**
const mixin Xtest
{
  **
  ** Name of the test
  **
  abstract Str name()
  
  **
  ** This test belongs to this classname.
  **
  abstract Str classname()
  
  **
  ** Package/pod name
  **
  abstract Str pod()
}
