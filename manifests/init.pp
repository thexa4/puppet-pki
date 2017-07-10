class pki {
  
  group { 'ssl-cert':
    ensure => present,
    system => true,
  }

  $host = $::trusted['certname']
  $ssldir = $::facts['puppet_ssldir']

  file { '/etc/ssl/private/host.key':
    ensure  => link,
    target  => "${ssldir}/private_keys/${host}.pem",
    require => [
      File["${ssldir}/private_keys"],
      File["${ssldir}/private_keys/${host}.pem"],
    ],
  }

  file { '/etc/ssl/private':
    ensure  => directory,
    group   => 'ssl-cert',
    require => Group['ssl-cert'],
  }

  file { "${ssldir}/private_keys":
    ensure  => directory,
    group   => 'ssl-cert',
    require => Group['ssl-cert'],
  }

  file { "${ssldir}/private_keys/${host}.pem":
    ensure  => present,
    group   => 'ssl-cert',
    require => Group['ssl-cert'],
  }

  file { '/etc/ssl/certs/host.crt':
    ensure => link,
    target => "${ssldir}/certs/${host}.pem",
  }

  file { '/etc/ssl/certs/host-ca.crt':
    ensure => link,
    target => "${ssldir}/certs/ca.pem",
  }
}
