class base::crontabs {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
    user     => 'root',
    minute   => fqdn_rand(60),
  }
    $hiera_config = hiera_hash('base::crontabs', undef)
    if $hiera_config {
      create_resources(cron, $hiera_config, $defaults)
    }
}
