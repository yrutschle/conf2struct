/* Example parser for conf2struct, using sslh configuration file. */

#include <string.h>
#include <stdlib.h>
#include <libconfig.h>

#include "example.h"

void main(void) {
    struct libc_eg_item config;
    const char* err;
    int res;

    res = libc_eg_parse_file("example.cfg", &config, &err);

    if (!res) {
        fprintf(stderr, "%s\n", err);
        exit(1);
    }

    libc_eg_print(&config,0);
}

