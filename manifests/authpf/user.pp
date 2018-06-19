# Define different rules or login message for a particular user.
#
# @example Allow all users
#   include ::pf::authpf
#   ::pf::authpf::user { 'alice':
#     message => @(EOS/L),
#       You have super powers
#       | EOS
#     rules   => @(EOS/L),
#       pass in from $user_ip to any
#       | EOS
#   }
#
# @param message
# @param rules
# @param user
#
# @see puppet_classes::pf::authpf ::pf::authpf
#
# @since 1.0.0
define pf::authpf::user (
  String           $user    = $title,
  Optional[String] $message = undef,
  Optional[String] $rules   = undef,
) {

  if ! defined(Class['::pf::authpf']) {
    fail('You must include the pf::authpf base class before using any pf::authpf defined resources')
  }

  unless $message or $rules {
    fail('At least one of $message or $rules should be specified.')
  }

  file { "${::pf::authpf::conf_dir}/users/${user}":
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  if $message {
    file { "${::pf::authpf::conf_dir}/users/${user}/authpf.message":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $message,
    }
  }

  if $rules {
    file { "${::pf::authpf::conf_dir}/users/${user}/authpf.rules":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $rules,
    }
  }
}
