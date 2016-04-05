hiera_include('classes')

node default {
	$return = hiera('test')
	notice("hmmm: $return")
}
