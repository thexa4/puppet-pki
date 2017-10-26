class pki {
  
  group { 'ssl-cert':
    ensure => present,
    system => true,
  }

  $host = $::trusted['certname']
  $ssldir = $::facts['puppet_ssldir']

  file { '/etc/ssl/private/host.key':
    ensure  => file,
    source  => "${ssldir}/private_keys/${host}.pem",
    group   => 'ssl-cert',
    mode    => '0640',
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

  file { '/etc/ssl/certs/host.crt':
    ensure => file,
    group   => 'ssl-cert',
    source => "${ssldir}/certs/${host}.pem",
  }

  file { '/etc/ssl/certs/host-ca.crt':
    ensure => file,
    group   => 'ssl-cert',
    source => "${ssldir}/certs/ca.pem",
  }
}
