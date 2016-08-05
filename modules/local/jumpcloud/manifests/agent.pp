class jumpcloud::agent ($key = "default") {

	$install = ["curl","sudo","bash","uuid-runtime"]
	ensure_resource('package', $install, {ensure => installed})

	notify {"Running with ${jumpcloud::agent::key} defined":}	
	exec { 'agent_install' :
  		command => "curl --silent --show-error --header 'x-connect-key: ${key}' 'https://kickstart.jumpcloud.com/Kickstart' | sudo bash",
  		path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
  		timeout => 2400,
  		creates => '/opt/jc'
	}
}
