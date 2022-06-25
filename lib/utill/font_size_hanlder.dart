class FontSizeHandle {
  double size = 12;

  double getAppBarFontSize(double fontSize) {
    if (fontSize > 0.8) {
      return 15;
    } else {
      return 19;
    }
  }

  double getAppBarFontSizeMain(double fontSize, String text, bool isContent) {
    print(fontSize);
    if (text == "Knowledge Base") {
      if (fontSize > 0.9) {
        return 19;
      } else if (fontSize >= 0.8) {
        return 22;
      } else {
        if (isContent) {
          return 20;
        } else {
          return 30;
        }
      }
    } else {
      if (fontSize > 0.9) {
        return 22;
      } else if (fontSize >= 0.8) {
        return 24;
      } else {
        if (isContent) {
          return 20;
        } else {
          return 30;
        }
      }
    }
  }
}
