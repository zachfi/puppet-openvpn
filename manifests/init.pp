# Class: openvpn
#
# Install OpenVPN and configure the service to start
class openvpn(
  $openvpn_dir  = $openvpn::params::openvpn_dir,
  $package_name = $openvpn::params::package_name,
) inherits openvpn::params {

  package { $package_name:
    ensure => installed,
  }->

  file { $openvpn_dir:
    ensure => directory,
  }->

  file { "${openvpn_dir}/${ccd}":
    ensure => directory,
  }

  if $::operatingsystem == 'OpenBSD' {
    # ssh service definition for OpenBSD, there is no
    # init script for this on OpenBSD
    service { 'openvpn':
      start    => '/etc/rc.d/openvpn start',
      stop     => '/etc/rc.d/openvpn stop',
      status   => '/etc/rc.d/openvpn check',
      restart  => '/etc/rc.d/openvpn restart',
      ensure   => 'running',
      # the provider selected by puppet 2.7 does not work
      provider => 'base',
      require  => [File['/etc/rc.d/openvpn'], File[$openvpn_dir]],
    }
    file {'/etc/rc.d/openvpn':
      owner => 'root',
      group => 'wheel',
      mode  => '0755',
      source => 'puppet:///modules/openvpn/openvpn-rc.d',
    }
    file_line {'enable_openvpn':
      path => '/etc/rc.conf.local',
      line => "openvpn_flags=\"--cd ${openvpn_dir} --config ${openvpn_dir}/openvpn.conf --daemon\""
    }
  } else {
    service {
      'openvpn':
        enable  => true,
        ensure  => running,
        require => File[$openvpn_dir],
    }
  }
}
