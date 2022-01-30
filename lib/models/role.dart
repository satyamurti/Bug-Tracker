enum Role {
  lead,
  maintainer,
  developer,
  user,
}

const roleList = ['Lead', 'Maintainer', 'Developer', 'User'];

Role roleFromString(String s) {
  switch (s) {
    case 'Lead':
      return Role.lead;
    case 'Maintainer':
      return Role.maintainer;
    case 'Developer':
      return Role.developer;
    default:
      return Role.user;
  }
}
