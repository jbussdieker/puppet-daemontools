define daemontools::service(
	$ensure="running",
	$logpath = '',
	$service_script = '',
	$command = '',
	$logfiles = 100,
	$logsize = 16777215,
) {

  include daemontools

  #
  # Log path structure
  #
  if $logpath != '' {
    $real_logpath = $logpath
  } else {
    $real_logpath = "/var/log/${name}"
  }

  if $service_script == '' {
    $service_content = template('daemontools/service.erb')
  } else {
    $service_content = $service_script
  }

  file {$real_logpath:
    ensure => directory,
  }

  #
  # Folder structure
  #

  file {"/etc/${name}":
    ensure => directory,
    notify => Service[$name],
  }

  file {"/etc/${name}/supervise":
    ensure  => directory,
    require => File["/etc/${name}"],
    notify  => Service[$name],
  }

  file {"/etc/${name}/log":
    ensure  => directory,
    require => File["/etc/${name}"],
    notify  => Service[$name],
  }

  #
  # Run files
  #

  file {"/etc/${name}/log/run":
    ensure  => present,
    mode    => '0755',
    content => template("daemontools/log.erb"),
    require => File["/etc/${name}/log"],
    notify  => Service[$name],
  }

  file {"/etc/${name}/run":
    ensure  => present,
    mode    => '0755',
    content => $service_content,
    require => File["/etc/${name}"],
    notify  => Service[$name],
  }

  #
  # Service
  #

  service { $name:
    ensure   => $ensure,
    provider => daemontools,
    require  => [
      File["/etc/${name}/run"],
      File["/etc/${name}/supervise"],
    ],
  }

}
