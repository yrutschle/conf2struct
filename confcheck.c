#include <libconfig.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    config_t c;
    char* filename = argv[1];

    if (argc != 2) {
        printf("Usage:\n\tconfcheck <file.cfg>\n");
        exit(1);
    }

    config_init(&c);
    if (config_read_file(&c, filename) == CONFIG_FALSE) {
        if (config_error_line(&c) != 0) {
           printf( "%s:%d:%s\n", 
                    filename,
                    config_error_line(&c),
                    config_error_text(&c));
           exit(2);
        }
        printf("%s:%s\n", filename, config_error_text(&c));
        exit(3);
    }
    printf("OK\n");
    exit(0);
}
