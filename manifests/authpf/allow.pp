# Explicitly allow a user access.
#
# @example Allow all users
#   include ::pf::authpf
#   ::pf::authpf::allow { '*': }
#
# @param user
#
# @see puppet_classes::pf::authpf ::pf::authpf
#
# @since 1.0.0
define pf::authpf::allow (
  String $user = $title,
) {

  if ! defined(Class['::pf::authpf']) {
    fail('You must include the pf::authpf base class before using any pf::authpf defined resources')
  }

  # The file should only exist if there's at least one allow rule
  ensure_resource('concat', "${::pf::authpf::conf_dir}/authpf.allow", {
    owner => 0,
    group => 0,
    mode  => '0644',
  })

  ::concat::fragment { "${::pf::authpf::conf_dir}/authpf.allow ${user}":
    content => "${user}\n",
    target  => "${::pf::authpf::conf_dir}/authpf.allow",
  }
}
