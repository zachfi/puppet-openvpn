class openvpn::server (
    $port                     = '1194',
    $proto                    = 'udp',
    $dev                      = 'tun',
    $cert                     = "server.crt",
    $key                      = "server.key",
    $ca                       = "ca.crt",
    $dh                       = "dh2048.pem",
    $server                   = "10.8.0.0 255.255.255.0",
    $route                    = '',
    $cipher                   = "AES-192-CBC",
    $dns                      = '',
    $redirect_gateway         = '',
    $log                      = '',
    $log_append               = '',
    $client_cert_not_required = '',
    $username_as_common_name  = '',
    $plugins                  = '',
    $crl                      = '',
    $openvpn_dir              = $openvpn::params::openvpn_dir,
    $openvpn_user             = 'nobody',
    $openvpn_group            = 'nobody'
  ) inherits openvpn::params {
  include openvpn
  include openvpn::params


  if ( $log_append != '' ) and ( $log != '' ){
    err("Log_append and log should not both be defined")
  }



  # Server configuration file
  #file { "${openvpn_dir}/${name}.conf":
  file { "${openvpn_dir}/openvpn.conf":
    owner   => root,
    group   => 0,
    mode    => 0600,
    content => template("openvpn/server.conf.erb");
  }



  exec { "create ${dh}":
    cwd     => "${openvpn_dir}",
    command => "/usr/bin/openssl dhparam -out ${dh} 2048",
    creates => "${openvpn_dir}/${dh}",
    before  => Service["openvpn"],
  }


}
