import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../baby_log.dart';
import '../models/entry_model.dart';
import '../../../../core/utils/date.dart';

class LogLocalDataSource {
  static const _kKey = 'entries_v1';

  Future<List<Entry>> getForDay(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    final all = list.map(EntryModel.fromJson).map((m) => m.toEntity()).toList();
    final target = ymd(day);
    return all.where((e) => ymd(e.at) == target).toList()
      ..sort((a, b) => b.at.compareTo(a.at));
  }

  Future<void> upsert(Entry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey);
    final list = raw == null
        ? <Map<String, dynamic>>[]
        : (jsonDecode(raw) as List).cast<Map<String, dynamic>>();

    // remove existing with same id
    list.removeWhere((m) => m['id'] == entry.id);
    list.add(EntryModel.fromEntity(entry).toJson());

    await prefs.setString(_kKey, jsonEncode(list));
  }

  Future<void> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey);
    if (raw == null) return;
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    list.removeWhere((m) => m['id'] == id);
    await prefs.setString(_kKey, jsonEncode(list));
  }
}