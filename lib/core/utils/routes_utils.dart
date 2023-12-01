enum PAGES {
  auth,
  home,
  stage,
  complete,
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
      case PAGES.complete:
        return "/complete";
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
      case PAGES.complete:
        return "complete";
      default:
        return "home";
    }
  }
}
