import 'package:flutter/material.dart';

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
class MainContainer extends StatelessWidget {
  MainContainer({super.key});
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'LEFT', icon: Icon(Icons.tag_faces)),
    const Tab(text: 'RIGHT', icon: Icon(Icons.ac_unit)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: tabs.map((Tab tab) {
            final String label = tab.text.toString().toLowerCase();
            return Center(
              child: Text(
                'This is the $label tab',
                style: const TextStyle(fontSize: 36),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

