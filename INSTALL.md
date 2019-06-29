`conf2struct` only has one Perl dependency that is not part
of the core distribution. It can be isntalled from `cpan`:

```
cpan Conf::Libconfig
```

The C parser obviously depends on `libconfig`, for which
headers are required. In Debian:

```
apt install libconfig8-dev
```
