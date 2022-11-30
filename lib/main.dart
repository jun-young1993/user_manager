import 'package:flutter/material.dart';
import 'package:user_manager/main_container.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "UserManager",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainContainer());
  }
}

// MaterialApp(
//       home: DefaultTabController(
//           child: Scaffold(
//     appBar: AppBar(
//         title: Text("Tabs"),
//         bottom: TabBar(
//           tabs: [Tab(icon: Icon(Icons.apps), text: "앱")],
//         )),
//   )))
