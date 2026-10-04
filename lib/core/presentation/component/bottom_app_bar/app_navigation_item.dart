import '../../../../ui/app_assets.dart';

enum AppNavigationItem {
  home(label: '홈', asset: AppAssets.home),
  memories(label: '기억들', asset: AppAssets.memories),
  bucket(label: '버킷', asset: AppAssets.buckets),
  timeCapsule(label: '타임캡슐', asset: AppAssets.capsules),
  settings(label: '설정', asset: AppAssets.settings);

  final String label;
  final String asset;

  const AppNavigationItem({required this.label, required this.asset});
}
