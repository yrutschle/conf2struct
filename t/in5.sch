header: "c2s.h"
parser: "c2s.c"

printer: true;

includes: ( "stdio.h", " <stdlib.h>" );

conffile_option: ("F", "conffile");

# Config file to test dash/underscore substitution

config: {
         name : "eg",
         type: "list",
         items: (
            { name: "my_int1"; type: "int"; },
            { name: "my-int2"; type: "int"; }
          )
}

