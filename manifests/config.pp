# @!visibility private
class pf::config {

  exec { "/sbin/pfctl -f ${::pf::conf_file}":
    refreshonly => true,
  }

  file { $::pf::conf_file:
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0600',
    content      => $::pf::content,
    source       => $::pf::source,
    validate_cmd => '/sbin/pfctl -n -f %',
    notify       => Exec["/sbin/pfctl -f ${::pf::conf_file}"],
  }
}
