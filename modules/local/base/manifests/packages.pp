class base::packages() { 

	$install = hiera_array('base::packages::install', [])
	$purge = hiera_array('base::packages::purge', [])

	package { $install:
    		ensure =>  installed,
	}

	packages { $purge:
		ensure	=> purged,
  	}	
}
