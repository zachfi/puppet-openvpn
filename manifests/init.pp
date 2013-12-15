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

  service { 'openvpn':
    ensure  => running,
    enable  => true,
  }
}
