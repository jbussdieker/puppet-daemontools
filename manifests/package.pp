class daemontools::package {

  package {'daemontools':
    ensure => present,
  }

  package {'daemontools-run':
    ensure  => present,
    require => Package['daemontools']
  }
}
