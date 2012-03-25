# OpenVPN

A puppet module for the OpenVPN VPN server.

## Supported Platforms

* Debian
* FreeBSD

## Usage

### Server Setup

    class { "openvpn::server":
      server => "10.0.0.0 255.255.255.0",
      route  => [
        "10.0.1.0 255.255.255.0",
        "10.0.2.0 255.255.255.0",
        "10.0.3.0 255.255.255.0",
        ],
      dns => '10.0.0.10',
      crl => 'mysite/crl.pem',
    }


### Client Specific Configurations

Clients can have a more specific and static configuration.

    openvpn::server::csc {
      "srv1.example.com":
        content => "ifconfig-push 10.0.0.50 10.0.0.51",
    }

### Client Setup

Clients can be connected to more than one server at a time.

    openvpn::client {
      "node_${hostname}_dc1":
        server => "vpn.dc1.example.com",
        cert   => "node_${hostname}";
      "node_${hostname}_office":
        server => "vpn.office.example.com",
        cert   => "node_${hostname}";
    }

