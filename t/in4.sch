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
            # 'integer' does not exist
            { name: "myint"; type: "integer"; short: "i"; }
          )
}

