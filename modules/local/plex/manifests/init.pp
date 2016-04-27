class plex {

	$url_plex = 'https://downloads.plex.tv/plex-media-server/0.9.16.6.1993-5089475/plexmediaserver_0.9.16.6.1993-5089475_amd64.deb'
	
	if ! defined(Package['curl']) { package { 'curl': ensure => installed } }
	Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

	exec { 'install-plex':
    		command => "curl --silent ${url_plex} > plex.deb && dpkg --install plex.deb && rm -rf plex.deb",
    		cwd     => '/tmp',
    		unless  => [
      			"stat /etc/init/plexmediaserver.conf",
    		],
    		require => Package['curl'],
  	}->

        file { "/usr/lib/plexmediaserver":
           ensure => directory,
           recurse => true,
           owner => "plex",
           group => "plex",
        }

 	file { "/var/lib/plexmediaserver":
           ensure => directory,
           recurse => true,
           owner => "plex",
           group => "plex",
        }  

        service { 'plexmediaserver':
                enable => true,
                ensure => running,
        }
}
