class transmission {
	
	package { [
			'transmission-cli', 
			'transmission-common', 
			'transmission-daemon',
  		]:
  		ensure  => 'installed',
	} -> 

	file { '/home/dunelm/.config/transmission-daemon/settings.json':
		content => template('transmission/settings.erb'),
    		owner => dunelm,
    		group => users,
    		mode => '600',
		notify => Service['transmission-daemon']
  	} ->

	file_line { 'change_user_systemd':
                path => '/etc/systemd/system/multi-user.target.wants/transmission-daemon.service',
                line => 'User=dunelm',
                match => '^User=*',
                notify => Service['transmission-daemon']
        } ->

 	exec { 'sysctl_reload':
                command => '/bin/systemctl daemon-reload',
        } ->

 	exec { 'set_cap':
                command => '/sbin/setcap cap_net_bind_service=+ep /usr/bin/transmission-daemon',
        }

	service { 'transmission-daemon':
    		enable => true,
		ensure => running,
  	}
}
