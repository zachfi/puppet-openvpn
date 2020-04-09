# Class: openvpn
#
# Install OpenVPN and configure the service to start
#
class openvpn (
  String $openvpn_dir,
  String $openvpn_path,
  String $package_name,
  Boolean $manage_service,
  Boolean $manage_systemd_unit,
  String $openvpn_group,
  String $openvpn_user,
  String $openssl,
) {

  package { $package_name:
    ensure => installed,
  }

  file { $openvpn_dir:
    ensure  => directory,
    require => Package[$package_name],
  }

  if $manage_service {
    service { 'openvpn':
      ensure  => running,
      enable  => true,
      require => File[$openvpn_dir],
    }
  }
}
