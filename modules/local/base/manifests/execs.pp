class base::execs (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  if $config {
    create_resources(exec, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('base::execs', undef)
    if $hiera_config {
      create_resources(exec, $hiera_config, $defaults)
    }
  }
}
