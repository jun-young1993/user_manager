import 'package:flutter/material.dart';
import 'package:user_manager/view/user/user_grid.dart';
class MainContainer extends StatelessWidget {
  MainContainer({super.key});
  final List<Tab> tabs = <Tab>[
    const Tab(text: '홈', icon: Icon(Icons.home)),
    const Tab(text: '사용자', icon: Icon(Icons.person)),
    const Tab(text: '설정', icon: Icon(Icons.settings))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        // appBar: AppBar(
        //     title : const Text("UserManager"),
        //     leading: const Icon(Icons.favorite, color : Colors.pink, size : 24.0, semanticLabel: "test favorite icon",),
        //     // bottom: TabBar(
        //     //   tabs: tabs,
        //     // ),
        //     ),
        bottomNavigationBar:
            Container(color: const Color(0xFF3F5AA6), child: TabBar(tabs: tabs)),
        body: TabBarView(
          children: tabs.map((Tab tab) {
            if(tab.text == '사용자'){
              return const Center(child:UserGrid());
            }
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
