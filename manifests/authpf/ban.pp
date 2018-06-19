# Explicitly ban user access.
#
# @example Ban a user
#   include ::pf::authpf
#   ::pf::authpf::ban { 'alice':
#     content => @(EOS/L),
#       You have violated the access policy!
#       | EOS
#   }
#
# @param content
# @param user
#
# @see puppet_classes::pf::authpf ::pf::authpf
#
# @since 1.0.0
define pf::authpf::ban (
  String $content,
  String $user    = $title,
) {

  if ! defined(Class['::pf::authpf']) {
    fail('You must include the pf::authpf base class before using any pf::authpf defined resources')
  }

  file { "${::pf::authpf::conf_dir}/banned/${user}":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $content,
  }
}
