enum ExcretionVolume {
  small,
  medium,
  large,
}

extension ExcretionVolumeLabel on ExcretionVolume {
  String get label => switch (this) {
        ExcretionVolume.small => '少',
        ExcretionVolume.medium => '中',
        ExcretionVolume.large => '多',
      };
}
