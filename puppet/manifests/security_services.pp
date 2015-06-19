node 'kerberos' {
  # Kerberos server (kdc and kadmin)
  class {'kerberos':
    master                => true,
    realm                 => 'TEST.LOCAL',
    kdc_database_password => 'secret',
  }

  # kerberos client
  #class {'kerberos':
  #  client            => true,
  #  realm             => 'TEST.LOCAL',
  #  domain_realm      => { '.test.local' => 'TEST.LOCAL', },
  #  kdcs              => ['cellserver.example.org'],
  #  admin_server      => 'cellserver.example.org',
  #  allow_weak_crypto => true,
  #}
  include kerberos
}

node 'ldap' {
  class { 'ldap::server':
    suffix  => 'dc=test,dc=local',
    rootdn  => 'cn=ldap,dc=test,dc=local',
    rootpw  => 'secret',
  }
}

node 'nis' {
  # NIS server
  class {'nis':
      ypdomain   => 'testdomain',
      ypserv     => 'nis.test.local',
      ypmaster   => 'nis.test.local',
      master     => true,
      securenets => '/var/yp/securenets',
      hostallow  => ['192.168.56.*'],
      groups     => ['users'],
  }

  include nis
}