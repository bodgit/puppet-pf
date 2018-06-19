# @!visibility private
class pf::authpf::config {

  $anchor = $::pf::authpf::anchor
  $table  = $::pf::authpf::table

  file { $::pf::authpf::conf_dir:
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  file { "${::pf::authpf::conf_dir}/authpf.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template("${module_name}/authpf.conf.erb"),
  }

  if $::pf::authpf::message {
    file { "${::pf::authpf::conf_dir}/authpf.message":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $::pf::authpf::message,
    }
  }

  if $::pf::authpf::problem {
    file { "${::pf::authpf::conf_dir}/authpf.problem":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $::pf::authpf::problem,
    }
  }

  if $::pf::authpf::rules {
    file { "${::pf::authpf::conf_dir}/authpf.rules":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $::pf::authpf::rules,
    }
  }

  file { "${::pf::authpf::conf_dir}/banned":
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  file { "${::pf::authpf::conf_dir}/users":
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }
}
