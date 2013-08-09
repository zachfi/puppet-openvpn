class openvpn::server (
    $ca                       = "ca.crt",
    $cert                     = "server.crt",
    $cipher                   = "AES-192-CBC",
    $client_cert_not_required = '',
    $crl                      = '',
    $dev                      = 'tun',
    $dh                       = "dh2048.pem",
    $dns                      = '',
    $domain                   = '',
    $ccd                      = $openvpn::params::ccd,
    $duplicate_cn             = '',
    $key                      = "server.key",
    $log                      = '',
    $log_append               = '',
    $openvpn_dir              = $openvpn::params::openvpn_dir,
    $openvpn_group            = 'nobody',
    $openvpn_user             = 'nobody',
    $plugins                  = '',
    $port                     = '1194',
    $proto                    = 'udp',
    $redirect_gateway         = '',
    $route                    = '',
    $server                   = "10.8.0.0 255.255.255.0",
    $username_as_common_name  = '',
    $script_security          = '',
    $client_connect           = '',
    $client_disconnect        = ''
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

