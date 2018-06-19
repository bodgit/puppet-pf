# Manage the packet filter (pf).
#
# @example Declaring the class
#   class { '::pf':
#     source => '/etc/examples/pf.conf',
#   }
#
# @param conf_file
# @param content
# @param source
#
# @see puppet_classes::pf::authpf ::pf::authpf
#
# @since 1.0.0
class pf (
  Stdlib::Absolutepath $conf_file = $::pf::params::conf_file,
  Optional[String]     $content   = undef,
  Optional[String]     $source    = undef,
) inherits ::pf::params {

  unless $content or $source {
    fail('Either $content or $source must be specified.')
  }

  if $content and $source {
    fail('Only one of $content or $source should be specified.')
  }

  contain ::pf::config
}
