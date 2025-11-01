import '../entities/vaccine.dart';
import '../entities/vaccine_master.dart';
import 'vaccination_period.dart';

const VaccineMaster japaneseNationalVaccinationMaster = VaccineMaster(
  version: '2024-01',
  periods: standardVaccinationPeriods,
  vaccines: <Vaccine>[
    Vaccine(
      id: 'hepatitis_b',
      name: 'B型肝炎',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は27日以上空ける'),
        VaccineNote(
          message: '①と③は139日以上空ける',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'rotavirus_monovalent',
      name: 'ロタウィルス(1価)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は27日以上空ける'),
      ],
    ),
    Vaccine(
      id: 'rotavirus_pentavalent',
      name: 'ロタウィルス(5価)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は27日以上空ける'),
        VaccineNote(message: '②と③も27日以上空ける'),
      ],
    ),
    Vaccine(
      id: 'pneumococcal',
      name: '肺炎球菌',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は27日以上空ける'),
        VaccineNote(message: '②と③は27日以上空ける'),
        VaccineNote(
          message: '③と④は60日以上空け、1才から1才3ヶ月の間に接種する',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'pentavalent',
      name: '5種混合',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は20〜56日空ける'),
        VaccineNote(message: '②と③は20〜56日空ける'),
        VaccineNote(
          message: '③と④は6ヶ月以上空け、18ヶ月までに接種する',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'tetravalent',
      name: '4種混合',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は20〜56日空ける'),
        VaccineNote(message: '②と③は20〜56日空ける'),
        VaccineNote(
          message: '③と④は6ヶ月以上空け、18ヶ月までに接種する',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'hib',
      name: 'ヒブ',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          doseNumbers: <int>[4],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は27〜56日空ける'),
        VaccineNote(message: '②と③は27〜56日空ける'),
        VaccineNote(
          message: '③と④は7〜13ヶ月空ける',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'bcg',
      name: 'BCG',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '5ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '2ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '1回のみの接種'),
      ],
    ),
    Vaccine(
      id: 'measles_rubella',
      name: '麻疹風疹(MR)',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '5才',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '6才',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(
          message: '2回目以降は小学校入学前の1年間に接種する',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'varicella',
      name: '水痘',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(
          message: '①と②は6〜12ヶ月空ける',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'japanese_encephalitis',
      name: '日本脳炎',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.mandatory,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '3才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '4才',
          doseNumbers: <int>[3],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6才',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(message: '①と②は6〜28日空ける'),
        VaccineNote(
          message: '②と③は1年空けて、4才の時に接種する',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'mumps',
      name: 'おたふくかぜ',
      category: VaccineCategory.live,
      requirement: VaccineRequirement.optional,
      priority: VaccinePriority.highlight,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[1],
          highlight: VaccinationPeriodHighlight.recommended,
        ),
        VaccineScheduleSlot(
          periodId: '5才',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.academyRecommendation,
        ),
        VaccineScheduleSlot(
          periodId: '6才',
          doseNumbers: <int>[2],
          highlight: VaccinationPeriodHighlight.academyRecommendation,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3才',
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4才',
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(
          message: '②はMRと同時期（小学校入学前の1年間）での接種を推奨',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
    Vaccine(
      id: 'influenza',
      name: 'インフルエンザ',
      category: VaccineCategory.inactivated,
      requirement: VaccineRequirement.optional,
      priority: VaccinePriority.highlight,
      schedule: <VaccineScheduleSlot>[
        VaccineScheduleSlot(
          periodId: '6ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '7ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '8ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '9ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才4ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '1才6ヶ月',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '2才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '3才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '4才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '5才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
        VaccineScheduleSlot(
          periodId: '6才',
          doseNumbers: <int>[1, 2],
          highlight: VaccinationPeriodHighlight.available,
        ),
      ],
      notes: <VaccineNote>[
        VaccineNote(
          message: '13才未満は2回接種。①と②は4週間空ける',
          severity: VaccineNoteSeverity.attention,
        ),
      ],
    ),
  ],
);
