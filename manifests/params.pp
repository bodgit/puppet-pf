# @!visibility private
class pf::params {

  case $::facts['os']['family'] {
    'OpenBSD': {
      $authpf_conf_dir = '/etc/authpf'
      $conf_file       = '/etc/pf.conf'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::facts['os']['family']} based system.")
    }
  }
}
