class base::packages() { 

	$install = hiera_array('base::packages::install', [])
	$purge = hiera_array('base::packages::purge', [])

	ensure_resource('package', $install, {ensure =>  installed})

	packages { $purge:
		ensure	=> purged,
  	}	
}
