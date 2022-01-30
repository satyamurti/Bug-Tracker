enum BugPriority {
  minor,
  medium,
  high,
  critical,
  catastrophic,
}

const priorityList = ['Minor', 'Medium', 'High', 'Critical', 'Catastrophic'];

BugPriority priorityFromString(String s) {
  switch (s) {
    case 'Minor':
      return BugPriority.minor;
    case 'Medium':
      return BugPriority.medium;
    case 'High':
      return BugPriority.high;
    case 'Critical':
      return BugPriority.critical;
    case 'Catastrophic':
      return BugPriority.catastrophic;
    default:
      return BugPriority.minor;
  }
}
