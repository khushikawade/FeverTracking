import 'dart:ui';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
  // For using user profile change detection
  UserProfileChanged onUserProfileChanged;
}

Application application = Application();

typedef void UserProfileChanged(obj);
