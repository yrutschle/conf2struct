/* Example parser for conf2struct, using sslh configuration file. */

#include <string.h>
#include <stdlib.h>
#include <libconfig.h>

#include "example.h"

void main(int argc, char* argv[]) {
    struct eg_item config, config_cl;
    const char* err;
    int res;

    res = eg_cl_parse(argc, argv, &config_cl);
    if (!res) {
        exit(1);
    }
    printf("from command line:\n");
    eg_print(&config_cl,0);
}

