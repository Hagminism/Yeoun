import '../../../../ui/app_assets.dart';
import 'app_navigation_item.dart';

abstract final class AppNavigationItems {
  static const List<AppNavigationItem> all = [
    AppNavigationItem(label: '홈', asset: AppAssets.home),
    AppNavigationItem(label: '기억들', asset: AppAssets.memories),
    AppNavigationItem(label: '버킷', asset: AppAssets.buckets),
    AppNavigationItem(label: '타임캡슐', asset: AppAssets.capsules),
    AppNavigationItem(label: '설정', asset: AppAssets.settings),
  ];
}
