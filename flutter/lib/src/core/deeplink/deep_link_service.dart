import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/child_record/domain/value/record_type.dart';
import '../../features/child_record/presentation/viewmodels/record_view_model.dart';
import '../router/app_router.dart';

part 'deep_link_service.g.dart';

/// ディープリンクのアクション種別
sealed class DeepLinkAction {
  const DeepLinkAction();
}

/// 記録追加アクション
class AddRecordAction extends DeepLinkAction {
  const AddRecordAction({required this.recordType});

  final RecordType recordType;
}

/// 不明なアクション
class UnknownAction extends DeepLinkAction {
  const UnknownAction({required this.uri});

  final Uri uri;
}

/// ディープリンク処理サービス
///
/// ウィジェットからのクイックアクションなど、
/// アプリ外部からのディープリンクを処理する。
class DeepLinkService {
  DeepLinkService(this._ref);

  final Ref _ref;
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;
  bool _isInitialized = false;

  /// サービスを初期化し、ディープリンクの監視を開始
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // アプリ起動時の初期リンクを処理
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleUri(initialUri);
    }

    // アプリ実行中のリンクを監視
    _subscription = _appLinks.uriLinkStream.listen(_handleUri);
  }

  /// サービスを破棄
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _isInitialized = false;
  }

  /// URIを解析してアクションに変換
  DeepLinkAction? parseUri(Uri uri) {
    // milu://record/add?type=breastRight
    if (uri.scheme != 'milu') return null;

    if (uri.host == 'record' && uri.path == '/add') {
      final typeString = uri.queryParameters['type'];
      if (typeString != null) {
        final recordType = _parseRecordType(typeString);
        if (recordType != null) {
          return AddRecordAction(recordType: recordType);
        }
      }
    }

    return UnknownAction(uri: uri);
  }

  /// URIを処理
  void _handleUri(Uri uri) {
    final action = parseUri(uri);
    if (action == null) return;

    switch (action) {
      case AddRecordAction(:final recordType):
        _handleAddRecord(recordType);
      case UnknownAction():
        // 不明なアクションは無視
        break;
    }
  }

  /// 記録追加アクションを処理
  void _handleAddRecord(RecordType recordType) {
    // まずベビータブ（授乳表）に移動
    final router = _ref.read(appRouterProvider);
    router.go('/baby');

    // ルーティング完了後にダイアログを開く
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final notifier = _ref.read(recordViewModelProvider.notifier);
      notifier.openCreateRecord(
        type: recordType,
        initialDateTime: DateTime.now(),
      );
    });
  }

  /// 文字列からRecordTypeを解析
  RecordType? _parseRecordType(String typeString) {
    return switch (typeString) {
      'breastRight' => RecordType.breastRight,
      'breastLeft' => RecordType.breastLeft,
      'formula' => RecordType.formula,
      'pump' => RecordType.pump,
      'pee' => RecordType.pee,
      'poop' => RecordType.poop,
      'temperature' => RecordType.temperature,
      'other' => RecordType.other,
      _ => null,
    };
  }
}

@Riverpod(keepAlive: true)
DeepLinkService deepLinkService(Ref ref) {
  final service = DeepLinkService(ref);
  ref.onDispose(() => service.dispose());
  return service;
}
