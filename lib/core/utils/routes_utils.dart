enum PAGES {
  auth,
  home,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.auth:
        return "/auth";
      case PAGES.home:
        return "/";
      default:
        return "/auth";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.auth:
        return "auth";
      case PAGES.home:
        return "home";
      default:
        return "home";
    }
  }
}
