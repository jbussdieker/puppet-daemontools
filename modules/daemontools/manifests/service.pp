define daemontools::service($ensure="running", $logpath = '', $command) {

  if $logpath != '' {
    $u_logpath = $logpath
  } else {
    $u_logpath = "/etc/service/${name}/log"
  }

  #
  # Folder structure
  #

  file {"/etc/service/${name}":
    ensure => directory,
    notify => Service[$name],
  }

  file {"/etc/service/${name}/supervise":
    ensure  => directory,
    require => File["/etc/service/${name}"],
    notify  => Service[$name],
  }

  file {"/etc/service/${name}/log":
    ensure  => directory,
    require => File["/etc/service/${name}"],
    notify  => Service[$name],
  }

  #
  # Run files
  #

  file {"/etc/service/${name}/log/run":
    ensure  => present,
    mode    => 0755,
    content => template("daemontools/log.erb"),
    require => File["/etc/service/${name}/log"],
    notify  => Service[$name],
  }

  file {"/etc/service/${name}/run":
    ensure  => present,
    mode    => 0755,
    content => template("daemontools/service.erb"),
    require => File["/etc/service/${name}"],
    notify  => Service[$name],
  }

  #
  # Service
  #

  service { $name:
    ensure   => $ensure,
    provider => daemontools,
    require  => [
      File["/etc/service/${name}/run"],
      File["/etc/service/${name}/supervise"],
    ],
  }

}