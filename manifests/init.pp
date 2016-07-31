class pks {
	
	group { "ssl-cert":
		ensure => present,
		system => true,
	}

	file { "/etc/ssl/private/host.key":
		ensure => link,
		target => "/etc/puppetlabs/puppet/ssl/private_keys/${::fqdn}.pem",
		require => [
			File["/etc/puppetlabs/puppet/ssl/private_keys"],
			File["/etc/puppetlabs/puppet/ssl/private_keys/${::fqdn}.pem"],
		],
	}

	file { "/etc/ssl/private":
		ensure => directory,
		group => "ssl-cert",
		require => Group["ssl-cert"],
	}

	file { "/etc/puppetlabs/puppet/ssl/private_keys":
		ensure => directory,
		group => "ssl-cert",
		require => Group["ssl-cert"],
	}

	file { "/etc/puppetlabs/puppet/ssl/private_keys/${::fqdn}.pem":
		ensure => present,
		group => "ssl-cert",
		require => Group["ssl-cert"],
	}

	file { "/etc/ssl/certs/host.crt":
		ensure => link,
		target => "/etc/puppetlabs/puppet/ssl/certs/${::fqdn}.pem",
	}

	file { "/etc/ssl/certs/host-ca.crt":
		ensure => link,
		target => "/etc/puppetlabs/puppet/ssl/certs/ca.pem",
	}
}
