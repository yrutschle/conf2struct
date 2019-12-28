header: "c2s.h"
parser: "c2s.c"

printer: true;

includes: ( "stdio.h", " <stdlib.h>" );

conffile_option: ("F", "conffile");

# Imaginary config file with not too many mandatory option,
# to test setting from command line with no configuration
# file, and defaults in various situations

config: {
         name : "eg",
         type: "list",
         items: (
            # Mandatory
            { name: "myint"; type: "int"; short: "i"; },

            # Mandatory with default
            { name: "mymbool"; type: "bool"; default: true; },
            { name: "mymint"; type: "int";  default: 42; },
            { name: "mymint64"; type: "int64"; default: 42; },
            { name: "mymfloat"; type: "float"; default: 3.14159;  },
            { name: "mymstring"; type: "string"; default: "hello world"; },

            # Optional
            { name: "myobool"; type: "bool"; optional: true; },
            { name: "myoint"; type: "int";  optional: true;},
            { name: "myoint64"; type: "int64"; optional: true; },
            { name: "myofloat"; type: "float";  optional: true; },
            { name: "myostring"; type: "string";  optional: true; },

            # A deep group with defaults
            { name: "dgroup", 
              type: "group", 
              items: (
              {name: "dlvl2"; type: "group"; items: (
                  {name: "dlvl3"; type: "group"; items: (
                    { name: "gdmybool"; type: "bool"; short: "b"; default: false },
                    { name: "gdmyint"; type: "int"; short: "i";  default: 42 },
                    { name: "gdmyint64"; type: "int64"; short: "I"; default: 4242},
                    { name: "gdmyfloat"; type: "float";  short: "f"; default: 2.718 },
                    { name: "gdmystring"; type: "string";  short: "s"; default: "grouped string" }
                  )}
              )}
             )
            },

            # A list of groups
            { name: "list",
                type: "list",
                items: (
                      { name: "lmybool"; type: "bool"; short: "b"; },
                      { name: "lmyint"; type: "int"; short: "i"; },
                      { name: "lmyint64"; type: "int64"; short: "I"; },
                      { name: "lmyfloat"; type: "float";  short: "f"; },
                      { name: "lmystring"; type: "string";  short: "s"; }
                )
            }
        )
}

# Compound options.
cl_groups: (
    { name: "group1"; pattern: "([[:digit:]]),([[:digit:]]+),(.*)";
      argdesc: "<bool>,<int>,<str>";   # in deep group
      list: "dgroup.dlvl2.dlvl3";
      override: "gdmystring";
      targets: (
                { path: "gdmybool"; value: "$1" },
                { path: "gdmyint"; value: "$2" },
                { path: "gdmyint64"; value: "12341234" },
                { path: "gdmystring"; value: "$3" }
               );
      },

    { name: "list-edit"; pattern: "([[:digit:]]),([[:digit:]]+),(.*)";
      list: "list";
      override: "lmystring";
      targets: (
                { path: "lmybool"; value: "$1" },
                { path: "lmyint"; value: "$2" },
                { path: "lmyint64"; value: "12341234" },
                { path: "lmystring"; value: "$3" }
               );
      },

    { name: "list_add"; pattern: "([[:digit:]]),([[:digit:]]+)";
      list: "list";
      targets: (
                { path: "lmybool"; value: "$1" },
                { path: "lmyint"; value: "$2" },
                { path: "lmyint64"; value: "12341234" },
                { path: "lmystring"; value: "initialised string" }
               );
      }
)
