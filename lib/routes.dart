import 'package:flutter/material.dart';
import 'package:user_manager/core/fade_page_route.dart';
import 'package:user_manager/ui/screens/calendar/calendar.dart';
import 'package:user_manager/ui/screens/config/config.dart';
import 'package:user_manager/ui/screens/home/home.dart';
import 'package:user_manager/ui/screens/login/login.dart';
import 'package:user_manager/ui/screens/user/user.dart';
import 'package:user_manager/ui/screens/user_info/user_info.dart';

enum Routes { home, config, user, userInfo, calendar, login }

class _Paths {
  static const String login = '/login';
  static const String home = '/home';
  static const String user = '/home/user';
  static const String userInfo = '/home/user-info';
  static const String config = '/home/config';
  static const String calendar = '/home/calendar';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.config: _Paths.config,
    Routes.user: _Paths.user,
    Routes.userInfo: _Paths.userInfo,
    Routes.calendar: _Paths.calendar,
    Routes.login: _Paths.login
  };

  static String of(Routes route) => _pathMap[route] ?? home;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    print("generate Route settings name ${settings.name}");
    switch (settings.name) {
      case _Paths.user:
        return FadeRoute(page: UserScreen());
      case _Paths.userInfo:
        return FadeRoute(page: UserInfo());
      case _Paths.config:
        return FadeRoute(page: ConfigScreen());
      case _Paths.calendar:
        return FadeRoute(page: CalendarScreen());
      case _Paths.home:
        return FadeRoute(page: HomeScreen());
      case _Paths.login:
      default:
        return FadeRoute(page: LoginScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
