import 'package:flutter/material.dart';
import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/child_record/presentation/widgets/app_bar_child_info.dart';

import '../models/vaccine_info.dart';
import '../widgets/vaccines_legend.dart';
import '../components/vaccines_schedule_table.dart';

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

  static const List<VaccineInfo> _vaccines = <VaccineInfo>[
    VaccineInfo(
      name: 'B型肝炎',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '7ヶ月': <int>[3],
        '8ヶ月': <int>[3],
      },
    ),
    VaccineInfo(
      name: 'ロタウィルス(1価)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
      },
    ),
    VaccineInfo(
      name: 'ロタウィルス(5価)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '4ヶ月': <int>[3],
      },
    ),
    VaccineInfo(
      name: '肺炎球菌',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '4ヶ月': <int>[3],
        '12-15ヶ月': <int>[4],
      },
    ),
    VaccineInfo(
      name: '5種混合',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '4ヶ月': <int>[3],
        '12-15ヶ月': <int>[4],
        '16-17ヶ月': <int>[4],
        '18-23ヶ月': <int>[4],
      },
    ),
    VaccineInfo(
      name: '4種混合',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '4ヶ月': <int>[3],
        '12-15ヶ月': <int>[4],
        '16-17ヶ月': <int>[4],
        '18-23ヶ月': <int>[4],
      },
    ),
    VaccineInfo(
      name: 'ヒブ',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '2ヶ月': <int>[1],
        '3ヶ月': <int>[2],
        '4ヶ月': <int>[3],
        '12-15ヶ月': <int>[4],
        '16-17ヶ月': <int>[4],
      },
    ),
    VaccineInfo(
      name: 'BCG',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '5ヶ月': <int>[1],
        '6ヶ月': <int>[1],
        '7ヶ月': <int>[1],
      },
    ),
    VaccineInfo(
      name: '麻疹風疹(MR)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '12-15ヶ月': <int>[1],
        '16-17ヶ月': <int>[1],
        '18-23ヶ月': <int>[1],
        '5才': <int>[2],
        '6才': <int>[2],
      },
    ),
    VaccineInfo(
      name: '水痘',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '12-15ヶ月': <int>[1],
        '18-23ヶ月': <int>[2],
      },
    ),
    VaccineInfo(
      name: '日本脳炎',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      doseSchedules: <String, List<int>>{
        '3才': <int>[1, 2],
        '4才': <int>[3],
      },
    ),
    VaccineInfo(
      name: 'おたふくかぜ',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.optional,
      doseSchedules: <String, List<int>>{
        '12-15ヶ月': <int>[1],
        '5才': <int>[2],
        '6才': <int>[2],
      },
    ),
    VaccineInfo(
      name: 'インフルエンザ',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.optional,
      doseSchedules: <String, List<int>>{
        '6ヶ月': <int>[1, 2],
        '7ヶ月': <int>[1, 2],
        '8ヶ月': <int>[1, 2],
        '9-11ヶ月': <int>[1, 2],
        '12-15ヶ月': <int>[1, 2],
        '16-17ヶ月': <int>[1, 2],
        '18-23ヶ月': <int>[1, 2],
        '2才': <int>[1, 2],
        '3才': <int>[1, 2],
        '4才': <int>[1, 2],
        '5才': <int>[1, 2],
        '6才': <int>[1, 2],
      },
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
          child: VaccinesScheduleTable(
            periods: VaccinesPage._periods,
            vaccines: VaccinesPage._vaccines,
          ),
        ),
        const VaccinesLegend(),
      ],
    );
  }
}
