# Manage the User Shell for Authenticating Gateways (authpf).
#
# @example Declaring the class
#   include ::bsdauth::authpf
#   class { '::pf::authpf':
#     rules => @(EOS/L),
#       pass in proto tcp from $user_ip to any port { 80, 443 }
#       | EOS
#   }
#
# @param conf_dir
# @param anchor Specify a different pf anchor instead of `authpf`.
# @param message
# @param problem
# @param rules The contents of `/etc/authpf/authpf.rules`.
# @param table Specify a different pf table instead of `authpf_users`.
#
# @see puppet_classes::pf ::pf
# @see puppet_defined_types::pf::authpf::allow ::pf::authpf::allow
# @see puppet_defined_types::pf::authpf::ban ::pf::authpf::ban
# @see puppet_defined_types::pf::authpf::user ::pf::authpf::user
#
# @since 1.0.0
class pf::authpf (
  Stdlib::Absolutepath $conf_dir = $::pf::params::authpf_conf_dir,
  Optional[String]     $anchor   = undef,
  Optional[String]     $message  = undef,
  Optional[String]     $problem  = undef,
  Optional[String]     $rules    = undef,
  Optional[String]     $table    = undef,
) inherits ::pf::params {

  contain ::pf::authpf::config
}
