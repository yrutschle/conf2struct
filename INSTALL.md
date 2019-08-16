`conf2struct` only has one Perl dependency that is not part
of the core distribution. It can be installed from `cpan`:

```
cpan Conf::Libconfig
```

If you don't want to run this as root, you can use the
`liblocal-lib-perl` package and then, as your local user:

```
cpan -l Conf::Libconfig
```

The C parser obviously depends on `libconfig`, for which
headers are required. In Debian:

```
apt install libconfig8-dev
```
