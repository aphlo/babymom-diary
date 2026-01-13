import 'package:in_app_review/in_app_review.dart';

/// in_app_reviewパッケージのラッパーサービス
class InAppReviewService {
  InAppReviewService([InAppReview? inAppReview])
      : _inAppReview = inAppReview ?? InAppReview.instance;

  final InAppReview _inAppReview;

  /// In-App Reviewが利用可能かどうかを確認
  Future<bool> isAvailable() async {
    return _inAppReview.isAvailable();
  }

  /// In-App Reviewダイアログをリクエスト
  ///
  /// 注意: OS側の制限により、ダイアログが表示されない場合があります。
  /// また、ユーザーがレビューを送信したかどうかはアプリ側で検知できません。
  Future<void> requestReview() async {
    final isAvailable = await _inAppReview.isAvailable();
    if (isAvailable) {
      await _inAppReview.requestReview();
    }
  }

  /// ストアのアプリページを開く（フォールバック用）
  Future<void> openStoreListing(
      {String? appStoreId, String? microsoftStoreId}) async {
    await _inAppReview.openStoreListing(
      appStoreId: appStoreId,
      microsoftStoreId: microsoftStoreId,
    );
  }
}
