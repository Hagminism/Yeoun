import '../../../../ui/app_assets.dart';

enum AppNavigationItem {
  home(label: '홈', asset: AppAssets.home),
  bucket(label: '버킷리스트', asset: AppAssets.buckets),
  timeCapsule(label: '타임캡슐', asset: AppAssets.capsules),
  settings(label: '설정', asset: AppAssets.settings);

  final String label;
  final String asset;

  const AppNavigationItem({required this.label, required this.asset});
}
