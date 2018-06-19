# pf

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-pf.svg?branch=master)](https://travis-ci.org/bodgit/puppet-pf)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-pf/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-pf?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/pf.svg)](https://forge.puppetlabs.com/bodgit/pf)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with pf](#setup)
    * [Beginning with pf](#beginning-with-pf)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages the packet filter (pf) firewall primarily found on
OpenBSD. It manages the `/etc/pf.conf` configuration file containing the
firewall rules. It can also manage the user shell (authpf) used for
implementing an authenticating gateway.

OpenBSD is supported using Puppet 4.5.0 or later.

## Setup

### Beginning with pf

To use the default example ruleset:

```puppet
class { '::pf':
  source => '/etc/examples/pf.conf',
}
```

## Usage

To set up the authenticating gateway:

```puppet
include ::bsdauth
include ::bsdauth::authpf

class { '::pf':
  content => @(EOS/L),
    int_if="em0"
    ...
    ťable <authpf_users> persist
    ...
    anchor "authpf/*" in on $int_if
    ...
    | EOS
}

class { '::pf::authpf':
  rules => @(EOS/L),
    int_if="em0"
    ...
    pass in on $int_if inet from <authpf_users> to ! $int_if:network \
      keep state
    ...
    | EOS
}

group { 'alice':
  ensure => present,
}

user { 'alice':
  ensure     => present,
  gid        => 'alice',
  loginclass => 'authpf',
  managehome => true,
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-pf/](https://bodgit.github.io/puppet-pf/).

## Limitations

This module has been built on and tested against Puppet 4.5.0 and higher.

The module has been tested on:

* OpenBSD 6.2/6.3

## Development

The module has both [rspec-puppet](http://rspec-puppet.com) and
[beaker-rspec](https://github.com/puppetlabs/beaker-rspec) tests. Run them
with:

```
$ bundle exec rake test
$ PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=x.y.z bundle exec rake beaker:<nodeset>
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-pf).
