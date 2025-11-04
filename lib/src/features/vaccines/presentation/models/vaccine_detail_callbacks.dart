import 'package:flutter/widgets.dart';

import 'vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';

typedef VaccineReservationTap = void Function(
  BuildContext context,
  VaccineInfo vaccine,
  int doseNumber, {
  String? influenzaSeasonLabel,
  int? influenzaDoseOrder,
});

typedef ScheduledDoseTap = void Function(
  BuildContext context,
  VaccineInfo vaccine,
  int doseNumber,
  DoseStatusInfo statusInfo, {
  String? influenzaSeasonLabel,
  int? influenzaDoseOrder,
});
