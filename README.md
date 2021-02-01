# README #

## Xfant ##

Xfant is a `fant` like tool that exports the test results in XML format.

* Outputs xml is compatible with 
  [JUnit's XML](https://github.com/windyroad/JUnit-Schema/blob/master/JUnit.xsd).
* Can be used with [Jenkins](https://jenkins.io/index.html) to show test reports.

### Install ###

`fanr install -r http://eggbox.fantomfactory.org/fanr/ xfant`

### Usage ###

`fan xfant target`

Where target can be:

  - A pod name,
  - A type qualified name,
  - A method qualified name or
  - `-all` to test all pods installed

#### Example #####

  - `fan xfant xml`
  - `fan xfant xml::PullTest`
  - `fan xfant xml::PullTest.testPi`


## Usage with Jenkins ##

In order to create a *Fantom* project with 'xfant' follow the next 
steps.

1. Install the `xfant` pod.
2. Create a `Freestyle project` in Jenkins.
3. Add a `build` step `execute shell` with this code:

```bash
export FAN_ENV=util::PathEnv
export FAN_ENV_PATH=$WORKSPACE
fan build.fan
```
    
  to compile the pod.
    
4. Add another `build` step `execute shell` with this code:

```bash
export FAN_ENV=util::PathEnv
export FAN_ENV_PATH=$WORKSPACE
fan xfant your_pod_name > your_pod_name.xml
```
    
  to execute the tests and write the report in a file.
    
5. Add a `Post-build` action named `Publish JUnit test result report`.
   In `test report XMLs` use `*.xml`

## What is missing ##

  - Capture the standard output and standard error during the tests.
  - Each testsuite has an attribute called 'id' with the number of
    testsuite.
