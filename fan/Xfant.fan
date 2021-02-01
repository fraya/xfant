**
** Prepare the test cases and execute them, finally reports
** the results in Xml.
**
class Xfant
{      
  **
  ** Test runner
  **  
  TestRunner runner := TestRunner()
  
  **
  ** Test cases to execute
  **
  Xtest[] tests := [,]
  
  **
  ** Test results collected
  **
  XTestResult[] results := [,]
  
  **
  ** Constructor
  **
  new make(|This| f) { f(this) }
    
  **
  ** Add a target to test.
  **
  @Operator
  This add(Obj obj)
  {
    switch (obj.typeof)
    {
      case Pod#:
        return addTestsFromPod(obj)
      case Type#:
        return addTestFromType(obj)
      case Slot#:
        return addTestFromSlot(obj)
      case Xtest#:
        return addTest(obj)
      case Str#: 
        return addTestFromStr(obj)
      default:
        throw ArgErr("Unknown test ${obj}")
    }
  }
  
  **
  ** Add a test to execute
  **
  This addTest(Xtest test)
  {
    tests.add(test)
    return this
  }
   
  **
  ** Add a list of targets to test.
  **
  This addAll(Obj[] targets)
  {
    targets.each { add(it) }
    return this
  }
  
  **
  ** Add all test from a pod. For each class in the pod a new
  ** test is added.
  **
  This addTestsFromPod(Pod pod)
  {
    TestSuite.fromPod(pod).each { addTest(it) }
    return this
  }
  
  **
  ** Add a test from a type.
  **
  This addTestFromType(Type type)
  {
    addTest(TestSuite(type))
  }
  
  **
  ** Add a test from a method/slot.
  **
  This addTestFromSlot(Slot slot)
  {
    addTest(TestCase(slot))
  }
   
  **
  ** Match a 'pattern' with a slot, type or pod.
  **
  ** The 'Slot' pattern is in the form of 'pod::type.slot'.
  ** The 'Type' pattern is 'pod::type'.
  ** The 'Pod' pattern is 'pod'
  **
  This addTestFromStr(Str pattern)
  {
    testcase := TestCase.fromStr(pattern, false)
    if (testcase != null) return addTest(testcase)

    testtype := TestSuite.fromStr(pattern, false)
    if (testtype != null) return addTest(testtype)
      
    pod := Pod.find(pattern, false)
    if (pod != null) return addTestsFromPod(pod)

    throw ArgErr("Error in target ${pattern}")
  }
  
  **
  ** Write a report of the results in 'out' stream
  **
  Void report(OutStream out)
  {
    XmlReport(results).write(out)
  }
    
  **
  ** Run the test cases and saves the results
  **
  Void run()
  { 
    results = tests.map { runner.run(it) }
  }
  
  **
  ** There are tests cases?
  **
  Bool hasTests()
  {
    !tests.isEmpty
  }  
}  
