import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;

import '../models/vaccine_info.dart';
import '../styles/vaccine_schedule_highlight_styles.dart';
import 'package:babymom_diary/src/features/vaccines/domain/services/vaccination_period_calculator.dart';
import '../widgets/vaccine_table_cells.dart';

class VaccinesScheduleTable extends StatefulWidget {
  const VaccinesScheduleTable({
    super.key,
    required this.periods,
    required this.vaccines,
    this.childBirthday,
    this.onVaccineTap,
  });

  final List<String> periods;
  final List<VaccineInfo> vaccines;
  final DateTime? childBirthday;
  final ValueChanged<VaccineInfo>? onVaccineTap;

  @override
  State<VaccinesScheduleTable> createState() => _VaccinesScheduleTableState();
}

class _VaccinesScheduleTableState extends State<VaccinesScheduleTable> {
  static const double _headerHeight = 48;
  static const double _rowHeight = 48;
  static const double _firstColumnWidth = 108;
  static const double _periodColumnWidth = 48;

  late final ScrollController _leftColumnController;
  late final ScrollController _bodyVerticalController;
  late final ScrollController _headerHorizontalController;
  late final ScrollController _bodyHorizontalController;

  bool _isSyncingVerticalFromLeft = false;
  bool _isSyncingVerticalFromBody = false;
  bool _isSyncingHorizontalFromHeader = false;
  bool _isSyncingHorizontalFromBody = false;

  @override
  void initState() {
    super.initState();
    _leftColumnController = ScrollController();
    _bodyVerticalController = ScrollController();
    _headerHorizontalController = ScrollController();
    _bodyHorizontalController = ScrollController();

    _leftColumnController.addListener(_handleLeftColumnScroll);
    _bodyVerticalController.addListener(_handleBodyVerticalScroll);
    _headerHorizontalController.addListener(_handleHeaderHorizontalScroll);
    _bodyHorizontalController.addListener(_handleBodyHorizontalScroll);
  }

  @override
  void dispose() {
    _leftColumnController.removeListener(_handleLeftColumnScroll);
    _bodyVerticalController.removeListener(_handleBodyVerticalScroll);
    _headerHorizontalController.removeListener(_handleHeaderHorizontalScroll);
    _bodyHorizontalController.removeListener(_handleBodyHorizontalScroll);

    _leftColumnController.dispose();
    _bodyVerticalController.dispose();
    _headerHorizontalController.dispose();
    _bodyHorizontalController.dispose();
    super.dispose();
  }

  void _handleLeftColumnScroll() {
    if (_isSyncingVerticalFromBody || !_leftColumnController.hasClients) {
      return;
    }
    final double offset = _leftColumnController.offset;
    if (_bodyVerticalController.hasClients &&
        _bodyVerticalController.offset != offset) {
      _isSyncingVerticalFromLeft = true;
      _bodyVerticalController.jumpTo(offset);
      _isSyncingVerticalFromLeft = false;
    }
  }

  void _handleBodyVerticalScroll() {
    if (_isSyncingVerticalFromLeft || !_bodyVerticalController.hasClients) {
      return;
    }
    final double offset = _bodyVerticalController.offset;
    if (_leftColumnController.hasClients &&
        _leftColumnController.offset != offset) {
      _isSyncingVerticalFromBody = true;
      _leftColumnController.jumpTo(offset);
      _isSyncingVerticalFromBody = false;
    }
  }

  void _handleHeaderHorizontalScroll() {
    if (_isSyncingHorizontalFromBody ||
        !_headerHorizontalController.hasClients) {
      return;
    }
    final double offset = _headerHorizontalController.offset;
    if (_bodyHorizontalController.hasClients &&
        _bodyHorizontalController.offset != offset) {
      _isSyncingHorizontalFromHeader = true;
      _bodyHorizontalController.jumpTo(offset);
      _isSyncingHorizontalFromHeader = false;
    }
  }

  void _handleBodyHorizontalScroll() {
    if (_isSyncingHorizontalFromHeader ||
        !_bodyHorizontalController.hasClients) {
      return;
    }
    final double offset = _bodyHorizontalController.offset;
    if (_headerHorizontalController.hasClients &&
        _headerHorizontalController.offset != offset) {
      _isSyncingHorizontalFromBody = true;
      _headerHorizontalController.jumpTo(offset);
      _isSyncingHorizontalFromBody = false;
    }
  }

  VaccinePeriodHighlightStyle? _highlightStyleFor(
    VaccineInfo vaccine,
    String periodLabel,
  ) {
    final domain.VaccinationPeriodHighlight? highlight =
        vaccine.periodHighlights[periodLabel];
    if (highlight == null) {
      return null;
    }
    return vaccinePeriodHighlightStyle(
      highlight: highlight,
      palette: vaccine.highlightPalette,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final DateTime? childBirthday = widget.childBirthday;
    final BorderSide borderSide = BorderSide(
      color: colorScheme.outlineVariant.withOpacity(0.6),
      width: 0.5,
    );

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GridCell(
              width: _firstColumnWidth,
              height: _headerHeight,
              backgroundColor: Colors.grey.shade100,
              border: Border(
                top: borderSide,
                left: borderSide,
                right: borderSide,
                bottom: borderSide,
              ),
              child: const HeaderCornerCell(text: '接種時期'),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _headerHorizontalController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: List<Widget>.generate(
                    widget.periods.length,
                    (int index) {
                      final String periodLabel = widget.periods[index];
                      final DateTime? scheduledDate =
                          VaccinationPeriodCalculator.dateForLabel(
                        birthday: childBirthday,
                        label: periodLabel,
                      );
                      return GridCell(
                        width: _periodColumnWidth,
                        height: _headerHeight,
                        backgroundColor: Colors.grey.shade100,
                        border: Border(
                          top: borderSide,
                          right: borderSide,
                          bottom: borderSide,
                        ),
                        child: HeaderPeriodCell(
                          label: periodLabel,
                          scheduledDate: scheduledDate,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _firstColumnWidth,
                child: ListView.builder(
                  controller: _leftColumnController,
                  padding: EdgeInsets.zero,
                  itemCount: widget.vaccines.length,
                  physics: const ClampingScrollPhysics(),
                  itemExtent: _rowHeight,
                  itemBuilder: (BuildContext context, int index) {
                    final vaccine = widget.vaccines[index];
                    final Color backgroundColor;
                    switch (vaccine.requirement) {
                      case domain.VaccineRequirement.mandatory:
                        backgroundColor = AppColors.primary.withOpacity(0.2);
                        break;
                      case domain.VaccineRequirement.optional:
                        backgroundColor = AppColors.secondary.withOpacity(0.2);
                        break;
                    }
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onVaccineTap == null
                          ? null
                          : () => widget.onVaccineTap!(vaccine),
                      child: GridCell(
                        width: _firstColumnWidth,
                        height: _rowHeight,
                        backgroundColor: backgroundColor,
                        border: Border(
                          left: borderSide,
                          right: borderSide,
                          bottom: borderSide,
                        ),
                        child: VaccineNameCell(vaccine: vaccine),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _bodyHorizontalController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    width: _periodColumnWidth * widget.periods.length,
                    child: ListView.builder(
                      controller: _bodyVerticalController,
                      padding: EdgeInsets.zero,
                      itemCount: widget.vaccines.length,
                      physics: const ClampingScrollPhysics(),
                      itemExtent: _rowHeight,
                      itemBuilder: (BuildContext context, int rowIndex) {
                        final VaccineInfo vaccine = widget.vaccines[rowIndex];
                        final List<Widget> periodCells = <Widget>[];
                        int columnIndex = 0;

                        while (columnIndex < widget.periods.length) {
                          final String periodLabel =
                              widget.periods[columnIndex];
                          final List<int> doseNumbers =
                              vaccine.doseSchedules[periodLabel] ??
                                  const <int>[];
                          final VaccinePeriodHighlightStyle? highlightStyle =
                              _highlightStyleFor(vaccine, periodLabel);
                          final bool hasSingleDose = doseNumbers.length == 1;
                          final int? currentDoseNumber =
                              hasSingleDose ? doseNumbers.first : null;

                          if (hasSingleDose) {
                            int runLength = 1;
                            int lookAheadIndex = columnIndex + 1;

                            while (lookAheadIndex < widget.periods.length) {
                              final String nextPeriodLabel =
                                  widget.periods[lookAheadIndex];
                              final List<int> nextDoseNumbers =
                                  vaccine.doseSchedules[nextPeriodLabel] ??
                                      const <int>[];

                              if (nextDoseNumbers.length == 1 &&
                                  nextDoseNumbers.first == currentDoseNumber) {
                                runLength += 1;
                                lookAheadIndex += 1;
                              } else {
                                break;
                              }
                            }

                            periodCells.add(
                              GridCell(
                                width: _periodColumnWidth,
                                height: _rowHeight,
                                backgroundColor: highlightStyle?.cellColor,
                                border: Border(
                                  right: borderSide,
                                  bottom: borderSide,
                                ),
                                child: DoseScheduleCell(
                                  doseNumbers: doseNumbers,
                                  arrowSegment: runLength > 1
                                      ? DoseArrowSegment.start
                                      : null,
                                  highlightStyle: highlightStyle,
                                ),
                              ),
                            );

                            if (runLength > 1) {
                              for (int offset = 1;
                                  offset < runLength;
                                  offset++) {
                                final int nextColumnIndex =
                                    columnIndex + offset;
                                final String nextPeriodLabel =
                                    widget.periods[nextColumnIndex];
                                final VaccinePeriodHighlightStyle?
                                    nextHighlightStyle = _highlightStyleFor(
                                  vaccine,
                                  nextPeriodLabel,
                                );
                                final bool isLast = offset == runLength - 1;
                                periodCells.add(
                                  GridCell(
                                    width: _periodColumnWidth,
                                    height: _rowHeight,
                                    backgroundColor:
                                        nextHighlightStyle?.cellColor,
                                    border: Border(
                                      right: borderSide,
                                      bottom: borderSide,
                                    ),
                                    child: DoseScheduleCell(
                                      doseNumbers: const <int>[],
                                      arrowSegment: isLast
                                          ? DoseArrowSegment.end
                                          : DoseArrowSegment.middle,
                                      highlightStyle: nextHighlightStyle,
                                    ),
                                  ),
                                );
                              }
                            }

                            columnIndex += runLength;
                            continue;
                          }

                          periodCells.add(
                            GridCell(
                              width: _periodColumnWidth,
                              height: _rowHeight,
                              backgroundColor: highlightStyle?.cellColor,
                              border: Border(
                                right: borderSide,
                                bottom: borderSide,
                              ),
                              child: DoseScheduleCell(
                                doseNumbers: doseNumbers,
                                highlightStyle: highlightStyle,
                              ),
                            ),
                          );
                          columnIndex += 1;
                        }

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: widget.onVaccineTap == null
                              ? null
                              : () => widget.onVaccineTap!(vaccine),
                          child: Row(children: periodCells),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
