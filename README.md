# Daemontools Module

[![Build Status](https://travis-ci.org/jbussdieker/puppet-daemontools.png?branch=master)](https://travis-ci.org/jbussdieker/puppet-daemontools)

This module facilitates installing and setting up services managed by Daemontools.

http://forge.puppetlabs.com/jbussdieker/daemontools

## Parameters

 * ensure: running, stopped. default: running
 * command: Command line to run service.
 * logpath: Directory to store log files in. default: /var/log/${name}
 * service_script: Write your own service script if you need more control, if you use this it makes the command paramter obsolete.
 * logfiles: The number of logfiles to keep
 * logsize: The maximum size of one logfile

## Usage

    daemontools::service {'myapp':
      ensure  => running,
      command => '/usr/bin/myapp',
      logpath => '/var/log/myapp',
    }
