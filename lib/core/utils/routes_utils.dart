enum PAGES {
  auth,
  home,
  stage,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.auth:
        return "/auth";
      case PAGES.home:
        return "/";
      case PAGES.stage:
        return "/stage";
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
      case PAGES.stage:
        return "stage";
      default:
        return "home";
    }
  }
}
