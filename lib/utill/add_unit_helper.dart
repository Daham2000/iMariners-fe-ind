class AddUnitHelper {
  String? getAddUnit(String key) {
    if (key == "banner") {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (key == "interstitial") {
      return "ca-app-pub-3940256099942544/8691691433";
    }
    return "";
  }
}
