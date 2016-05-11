class base::sudoers {
	file { '/etc/sudoers':
  	 	ensure => present,
	}->

	file_line { 'Password less sudo':
  		path => '/etc/sudoers',  
  		line => '%sudo   ALL=(ALL) NOPASSWD:ALL',
  		match   => "^\%sudo.*$",
	}
}
