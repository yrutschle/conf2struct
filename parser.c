/* Example parser for conf2struct, using sslh configuration file. */

#include <string.h>
#include <stdlib.h>
#include <libconfig.h>

#include "example.h"

void main(int argc, char* argv[]) {
    struct eg_item config_cl;
    int res;

    res = eg_cl_parse(argc, argv, &config_cl);
    if (res) {
        exit(1);
    }
    eg_fprint(stdout, &config_cl,0);
}

