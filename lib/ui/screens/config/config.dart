import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/ui/widgets/category_background.dart';

class ConfigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  static final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void logout() async {
    await storage.delete(key: 'database');
    AppNavigator.pop();
    AppNavigator.push(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return CategoryBackground(
      child: TextButton(
        child: Text("logout"),
        onPressed: () async {
          logout();
        },
      ),
    );
  }
}
