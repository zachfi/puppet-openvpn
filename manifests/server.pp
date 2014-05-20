# Class: openvpn::server
#
# Install and configure the OpenVPN server
#
class openvpn::server (
  $ca                       = 'ca.crt',
  $cert                     = 'server.crt',
  $cipher                   = 'AES-192-CBC',
  $client_cert_not_required = '',
  $crl                      = '',
  $dev                      = 'tun',
  $dev_type                 = '',
  $dh                       = 'dh2048.pem',
  $dns                      = '',
  $domain                   = '',
  $wins                     = '',
  $ccd                      = $openvpn::params::ccd,
  $duplicate_cn             = '',
  $key                      = 'server.key',
  $log                      = '',
  $log_append               = '',
  $status_log               = 'openvpn-status.log',
  $openvpn_dir              = $openvpn::params::openvpn_dir,
  $openvpn_group            = 'nobody',
  $openvpn_user             = 'nobody',
  $plugins                  = '',
  $verb                     = '3',
  $port                     = '1194',
  $proto                    = 'udp',
  $redirect_gateway         = '',
  $route                    = '',
  $server                   = '10.8.0.0 255.255.255.0',
  $username_as_common_name  = '',
  $script_security          = '',
  $client_connect           = '',
  $client_disconnect        = '',
  $tls_verify               = '',
  $custom_options           = []
) inherits openvpn::params {

  include openvpn

  if ( $log_append != '' ) and ( $log != '' ){
    err('Log_append and log should not both be defined')
  }

  # Server configuration file
  #file { "${openvpn_dir}/${name}.conf":
  file { "${openvpn_dir}/openvpn.conf":
    owner   => root,
    group   => 0,
    mode    => '0600',
    content => template('openvpn/server.conf.erb'),
    notify  => Service['openvpn'],
  }

  exec { "create ${dh}":
    cwd     => $openvpn_dir,
    command => "/usr/bin/openssl dhparam -out ${dh} 2048",
    creates => "${openvpn_dir}/${dh}",
    before  => Service['openvpn'],
  }
}
