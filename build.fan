using build

class Build : BuildPod
{
  new make()
  {
    podName = "xfant"
    summary = "Fant like tool that shows test results in JUnit Xml"
    version = Version("0.3.1")
    
    meta = [
      "stripTest" : "true"
    ]
    
    depends = [
      "sys 1.0+",
      "util 1.0+",
      "xml 1.0+"
    ]
    
    srcDirs = [
      `fan/`,
      `fan/case/`,
      `fan/result/`,
      `fan/report/`,
      `fan/runner/`,
      `test/`
    ] 
    
    resDirs = [
      `doc/`
    ]
  }
}
