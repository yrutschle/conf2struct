Each test uses:
- one schema file describing the contents of the target
  configuration file. Extension is `.sch`.
- one data file that complies to the schema. Extension is
  `.data`.
- one C parser
- one command line passed to the C parser
- one expected output file from the C parser

All C parsers expect the `conf2struct` output to `c2s.h` and
`c2s.c`.

The main script `run` creates one directory per schema file,
i.e. one directory per C parser under test. This allows to
run several tests on the same parser binary to achieve test
coverage of the C code.

`run` takes the following arguments:
- `--cover`: generate coverage reports. The Perl report will
  be located in `./cover_db/coverage.html`.
- a list of numbers, specifying which tests to run, or
  nothing to run all tests.
