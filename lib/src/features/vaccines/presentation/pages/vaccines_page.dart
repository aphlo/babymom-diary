import 'package:babymom_diary/src/features/child_record/presentation/widgets/app_bar_child_info.dart';
import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';

class VaccinesPage extends StatelessWidget {
  const VaccinesPage({super.key});

  static const List<String> _periods = <String>[
    '0ヶ月',
    '1ヶ月',
    '2ヶ月',
    '3ヶ月',
    '4ヶ月',
    '5ヶ月',
    '6ヶ月',
    '7ヶ月',
    '8ヶ月',
    '9-11ヶ月',
    '12-15ヶ月',
    '16-17ヶ月',
    '18-23ヶ月',
    '2才',
    '3才',
    '4才',
    '5才',
    '6才',
  ];

  static const List<_VaccineInfo> _vaccines = <_VaccineInfo>[
    _VaccineInfo(
      name: 'B型肺炎',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: 'ロタウィルス',
      category: _VaccineCategory.live,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '肺炎球菌',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '5種混合',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '4種混合',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: 'ヒブ',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: 'BCG',
      category: _VaccineCategory.live,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '麻疹・風疹(MR)',
      category: _VaccineCategory.live,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '水痘',
      category: _VaccineCategory.live,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: '日本脳炎',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.mandatory,
    ),
    _VaccineInfo(
      name: 'おたふくかぜ',
      category: _VaccineCategory.live,
      requirement: _VaccineRequirement.optional,
    ),
    _VaccineInfo(
      name: 'インフルエンザ',
      category: _VaccineCategory.inactivated,
      requirement: _VaccineRequirement.optional,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarChildInfo()),
      body: const _VaccinesContent(),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _VaccinesContent extends StatelessWidget {
  const _VaccinesContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _VaccinesScheduleTable(
            periods: VaccinesPage._periods,
            vaccines: VaccinesPage._vaccines,
          ),
        ),
        const _VaccinesLegend(),
      ],
    );
  }
}

class _VaccinesScheduleTable extends StatefulWidget {
  const _VaccinesScheduleTable({
    required this.periods,
    required this.vaccines,
  });

  final List<String> periods;
  final List<_VaccineInfo> vaccines;

  @override
  State<_VaccinesScheduleTable> createState() => _VaccinesScheduleTableState();
}

class _VaccinesScheduleTableState extends State<_VaccinesScheduleTable> {
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
            _GridCell(
              width: _firstColumnWidth,
              height: _headerHeight,
              backgroundColor: Colors.grey.shade100,
              border: Border(
                top: borderSide,
                left: borderSide,
                right: borderSide,
                bottom: borderSide,
              ),
              child: const _HeaderCornerCell(text: '接種時期'),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _headerHorizontalController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  children: List<Widget>.generate(
                    widget.periods.length,
                    (int index) => _GridCell(
                      width: _periodColumnWidth,
                      height: _headerHeight,
                      backgroundColor: Colors.grey.shade100,
                      border: Border(
                        top: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                      ),
                      child: _HeaderPeriodCell(label: widget.periods[index]),
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
                      case _VaccineRequirement.mandatory:
                        backgroundColor = AppColors.primary.withOpacity(0.2);
                        break;
                      case _VaccineRequirement.optional:
                        backgroundColor = AppColors.secondary.withOpacity(0.2);
                        break;
                    }
                    return _GridCell(
                      width: _firstColumnWidth,
                      height: _rowHeight,
                      backgroundColor: backgroundColor,
                      border: Border(
                        left: borderSide,
                        right: borderSide,
                        bottom: borderSide,
                      ),
                      child: _VaccineNameCell(vaccine: vaccine),
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
                            (int columnIndex) => _GridCell(
                              width: _periodColumnWidth,
                              height: _rowHeight,
                              border: Border(
                                right: borderSide,
                                bottom: borderSide,
                              ),
                              child: const _EmptyScheduleCell(),
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

class _VaccinesLegend extends StatelessWidget {
  const _VaccinesLegend();

  static const double _height = 64;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final BorderSide borderSide = BorderSide(
      color: colorScheme.outlineVariant.withOpacity(0.6),
      width: 0.5,
    );

    final _VaccineTypeStyles liveStyles =
        _vaccineTypeStyles(_VaccineCategory.live, colorScheme);
    final _VaccineTypeStyles inactivatedStyles =
        _vaccineTypeStyles(_VaccineCategory.inactivated, colorScheme);

    return Container(
      height: _height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(top: borderSide),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '凡例',
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 4,
              children: <Widget>[
                _LegendItem(
                  styles: liveStyles,
                  description: '生ワクチン',
                ),
                _LegendItem(
                  styles: inactivatedStyles,
                  description: '不活化ワクチン',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.styles,
    required this.description,
  });

  final _VaccineTypeStyles styles;
  final String description;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _TypeBadge(
          label: styles.label,
          backgroundColor: styles.backgroundColor,
          foregroundColor: styles.foregroundColor,
          borderColor: styles.borderColor,
        ),
        const SizedBox(width: 6),
        Text(
          description,
          style: textStyle,
        ),
      ],
    );
  }
}

class _HeaderCornerCell extends StatelessWidget {
  const _HeaderCornerCell({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _HeaderPeriodCell extends StatelessWidget {
  const _HeaderPeriodCell({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _VaccineNameCell extends StatelessWidget {
  const _VaccineNameCell({
    required this.vaccine,
  });

  final _VaccineInfo vaccine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final _VaccineTypeStyles styles =
        _vaccineTypeStyles(vaccine.category, colorScheme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            vaccine.name,
            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _TypeBadge(
            label: styles.label,
            backgroundColor: styles.backgroundColor,
            foregroundColor: styles.foregroundColor,
            borderColor: styles.borderColor,
          ),
        ],
      ),
    );
  }
}

class _EmptyScheduleCell extends StatelessWidget {
  const _EmptyScheduleCell();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.width,
    required this.height,
    required this.border,
    required this.child,
    this.backgroundColor,
  });

  final double width;
  final double height;
  final Border border;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        border: border,
      ),
      child: child,
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
              height: 1.1,
            ),
      ),
    );
  }
}

class _VaccineInfo {
  const _VaccineInfo({
    required this.name,
    required this.category,
    required this.requirement,
  });

  final String name;
  final _VaccineCategory category;
  final _VaccineRequirement requirement;
}

enum _VaccineCategory { live, inactivated }

enum _VaccineRequirement { mandatory, optional }

class _VaccineTypeStyles {
  const _VaccineTypeStyles({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
}

_VaccineTypeStyles _vaccineTypeStyles(
  _VaccineCategory category,
  ColorScheme colorScheme,
) {
  switch (category) {
    case _VaccineCategory.live:
      return _VaccineTypeStyles(
        label: '生',
        backgroundColor: colorScheme.error.withOpacity(0.12),
        foregroundColor: colorScheme.error,
        borderColor: colorScheme.error.withOpacity(0.4),
      );
    case _VaccineCategory.inactivated:
      return _VaccineTypeStyles(
        label: '不活化',
        backgroundColor: colorScheme.primary.withOpacity(0.12),
        foregroundColor: colorScheme.primary,
        borderColor: colorScheme.primary.withOpacity(0.4),
      );
  }
}
