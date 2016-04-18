class base::templates (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  if $config {
    create_resources('system::template', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('base::templates', undef)
    if $hiera_config {
      create_resources('system::template', $hiera_config, $defaults)
    }
  }
}

define base::template(
  $template,
  $owner    = 'root',
  $group    = 'root',
  $mode     = undef,
  $sys_schedule = 'always',
) {
  file { $title:
    owner    => $owner,
    group    => $group,
    mode     => $mode,
    schedule => $sys_schedule,
    content  => template($template),
  }
}
