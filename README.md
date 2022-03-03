Dist::Zilla::PluginBundle::Author::AJNN
=======================================

This is the configuration I use for [Dist::Zilla][].

This software has pre-release quality. There is little documentation
and no schedule for further development.

[Dist::Zilla]: https://metacpan.org/release/Dist-Zilla


Installation
------------

The installation of
[Dist::Zilla::PluginBundle::Author::AJNN](https://metacpan.org/release/Dist-Zilla-PluginBundle-Author-AJNN)
usually happens automatically when installing the author dependencies
for another distribution of mine:

    dzil authordeps --missing | cpanm

Released versions can also be installed independently from CPAN:

    cpanm Dist::Zilla::PluginBundle::Author::AJNN

[![CPAN distribution](https://badge.fury.io/pl/Dist-Zilla-PluginBundle-Author-AJNN.svg)](https://badge.fury.io/pl/Dist-Zilla-PluginBundle-Author-AJNN)

Note that `dzil authordeps` may not work correctly for this distribution
because it itself is used to build it. To install a development version
from this repository, running the following steps should work; otherwise
you may need to install some dependencies manually:

1. `git clone https://github.com/johannessen/dzil-pluginbundle && cd dzil-pluginbundle`
1. `cpanm Dist::Zilla::Plugin::Bootstrap::lib`
1. `dzil listdeps --missing | cpanm`
1. `dzil build`
1. `cpanm <archive>.tar.gz`
