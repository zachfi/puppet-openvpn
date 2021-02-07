# Class: openvpn
#
# Install OpenVPN and configure the service to start
#
class openvpn (
  String $openvpn_dir,
  Stdlib::Absolutepath $openvpn_path,
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
    Exec <| tag == 'openvpn' |> ~> Service['openvpn']
    File <| tag == 'openvpn' |> ~> Service['openvpn']

    service { 'openvpn':
      ensure  => running,
      enable  => true,
      name    => $server_service_name,
      require => File[$openvpn_dir],
    }
  }
}
