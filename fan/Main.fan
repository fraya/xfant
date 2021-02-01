using util

**
** Main execution point of Xfant pod.
**
class Main : AbstractMain
{
  @Arg { help = "<pod> [pod]* | <pod>::<test> | <pod>::<test>.<method>" }
  Str[] targets := [,]
  
  @Opt { help = "test all pods" }
  Bool all
        
  override Int run()
  {    
    Xfant? xfant
    
    //
    // Add tests to execute
    //
    
    try
    {
      xfant = Xfant {}
      xfant.addAll(all ? Pod.list : targets)
    } 
    catch (Err err)
    {
      log.err("Error in arguments: ${err.msg}", err)
      return -1
    }
    
    //
    // if no tests where given, show usage
    //
    
    if (!xfant.hasTests) 
    {
      return usage
    }
     
    //
    // Run tests
    //
    
    try
    {
      xfant.run
      xfant.report(Env.cur.out)
      return 0
    }
    catch (Err err)
    {
      log.err("Unexpected error running tests", err)
      return -1
    }
  }
}
 
