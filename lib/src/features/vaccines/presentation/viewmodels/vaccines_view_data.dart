import 'package:meta/meta.dart';

import '../models/vaccine_info.dart';

@immutable
class VaccinesViewData {
  const VaccinesViewData({
    required this.periodLabels,
    required this.vaccines,
    this.version,
    this.publishedAt,
  });

  final List<String> periodLabels;
  final List<VaccineInfo> vaccines;
  final String? version;
  final DateTime? publishedAt;
}
