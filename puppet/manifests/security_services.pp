kerberos::realm{'test.local':
  kdc => 'kerberos.test.local',
}
kerberos::domain_realm{'.test.local':
  realm => 'test.local',
}

include kerberos