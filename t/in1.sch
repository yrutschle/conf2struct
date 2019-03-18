# Example configuration to build a parser for libconfig's
# example. For a complete, complex example, look up sslh's
# configuration.

header: "c2s.h";
parser: "c2s.c";

#іncludes: (); # None in this project

conffile_option: ( "F", "conffile" );

config: {
name: "eg";
items: (
        { name: "version"; type: "string"; description: "Specify version number" },
        { name: "application"; type: "group", items: (
                 { name: "window"; type: "group", items: (
                        { name: "title"; type: "string"; description: "Specify window title" },
                        { name: "size" ; type: "group"; items: (
                             { name: "w"; type: "int" },
                             { name: "h"; type: "int" }
                        ) },
                        { name: "pos" ; type: "group"; items: (
                             { name: "x"; type: "int" },
                             { name: "y"; type: "int" }
                        ) }
                 ) },
# No support for lists of dynamic types
                 { name: "books"; type: "list"; items: (
                      { name: "title"; type: "string" },
                      { name: "author"; type: "string" },
                      { name: "price"; type: "float" },
                      { name: "qty"; type: "int" }
                 ) },

                 { name: "misc"; type: "group"; items: (
                      { name: "pi"; type: "float" },
                      { name: "bigint"; type: "int64" },
                      { name: "columns"; type: "array"; element_type: "string" },
                      { name: "bitmask"; type: "int" },
                      { name: "umask"; type: "int" }
                 ) }
        ) }
    )
}


# Now we also provide a simple compound command to specify
# books
cl_groups: (
       { name: "size"; pattern: "([[:digit:]]+)[,x]([[:digit:]]+)";
         list: "application.window.size";
         targets: (
                { path: "w"; value: "$1"; },
                { path: "h"; value: "$2"; }
         );
       },
       { name: "book";
         pattern: "(.+),(.+),([0-9.]+),([[:digit:]]+)";
         list: "application.books";
        override: "title";
         targets: (
                   { path: "title"; value: "$1" },
                   { path: "author"; value: "$2" },
                   { path: "price"; value: "$3" },
                   { path: "qty"; value: "$4" }
         );
       }
)
