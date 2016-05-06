class transmission {
	
	package { [
			'transmission-cli', 
			'transmission-common', 
			'transmission-daemon',
  		]:
  		ensure  => 'installed',
	} 

	exec { 'set_cap':
    		command => '/sbin/setcap cap_net_bind_service=+ep /usr/bin/transmission-daemon',
  	}	

	file { '/etc/transmission-daemon/settings.json':
		content => template('transmission/settings.erb'),
    		owner => debian-transmission,
    		group => debian-transmission,
    		mode => '600',
		notify => Service['transmission-daemon']
  	} 

	service { 'transmission-daemon':
    		enable => true,
		ensure => running,
  	}
}
