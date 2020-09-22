# Class: openvpn
#
# Install OpenVPN and configure the service to start
#
class openvpn (
  Stdlib::Absolutepath $openvpn_dir,
  String $package_name,
  Boolean $manage_service,
  Boolean $manage_systemd_unit,
  String $openvpn_group,
  String $openvpn_user,
  String $openssl,
  String $server_service_name,
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
      name    => $server_service_name,
      require => File[$openvpn_dir],
    }
  }
}
