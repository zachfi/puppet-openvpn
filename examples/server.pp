class { 'openvpn::server':
  server => '10.0.0.0 255.255.255.0',
  route  => [
    '10.0.1.0 255.255.255.0',
    '10.0.2.0 255.255.255.0',
    '10.0.3.0 255.255.255.0',
    ],
  dns    => '10.0.0.10',
  crl    => 'mysite/crl.pem',
}

openvpn::server::csc { 'srv1.example.com':
  content => 'ifconfig-push 10.0.0.50 10.0.0.51',
}
