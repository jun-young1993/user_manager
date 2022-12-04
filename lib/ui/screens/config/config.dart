import 'package:flutter/material.dart';
import 'package:user_manager/ui/widgets/category_background.dart';
class ConfigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
    @override
    void initState() {
      super.initState();
    }

    @override
    void dispose() {
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      return CategoryBackground(
        child: Text("config"),
      );
    }

}