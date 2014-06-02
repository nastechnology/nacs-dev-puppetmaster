node 'xp.nas.dev' {
  include roles
}

node 'osx.nas.dev' {
  class { 'roles::teacher::nhs::art': 
    user => '1009512',
  }

  nacs_management::tmutil { "testuser": }

}
