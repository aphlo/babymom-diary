import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';

import '../models/vaccine_info.dart';
import '../widgets/vaccine_table_cells.dart';

class VaccinesScheduleTable extends StatefulWidget {
  const VaccinesScheduleTable({
    super.key,
    required this.periods,
    required this.vaccines,
  });

  final List<String> periods;
  final List<VaccineInfo> vaccines;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                    (int index) => GridCell(
                      width: _periodColumnWidth,
                      height: _headerHeight,
                      backgroundColor: Colors.grey.shade100,
                      border: Border(
                        top: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                      ),
                      child: HeaderPeriodCell(label: widget.periods[index]),
                    ),
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
                      case VaccineRequirement.mandatory:
                        backgroundColor = AppColors.primary.withOpacity(0.2);
                        break;
                      case VaccineRequirement.optional:
                        backgroundColor = AppColors.secondary.withOpacity(0.2);
                        break;
                    }
                    return GridCell(
                      width: _firstColumnWidth,
                      height: _rowHeight,
                      backgroundColor: backgroundColor,
                      border: Border(
                        left: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                      ),
                      child: VaccineNameCell(vaccine: vaccine),
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
                        return Row(
                          children: List<Widget>.generate(
                            widget.periods.length,
                            (int columnIndex) => GridCell(
                              width: _periodColumnWidth,
                              height: _rowHeight,
                              border: Border(
                                right: borderSide,
                                bottom: borderSide,
                              ),
                              child: const EmptyScheduleCell(),
                            ),
                          ),
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
