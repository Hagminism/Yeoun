abstract final class AppBreakpoints {
  static const double navigationStart = 800;
  static const double navigationEnd = 1080;
  static const double twoColumnContent = 740;
  static const double maxContentWidth = 1120;

  static double desktopProgress(double width) {
    return ((width - navigationStart) / (navigationEnd - navigationStart))
        .clamp(0.0, 1.0);
  }
}
