
part of '../home.dart';


class _HeaderCardContent extends StatelessWidget {
    
    static const double height = 582;
    void _onSelectCategory(Category category) {

      print("cateogry click $category");
       AppNavigator.push(category.route);
    }
    @override
    Widget build(BuildContext context) {
      var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
          var isDark = themeCubit.isDark;
      return Container( 
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
        // color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        // border: Border(
        //   bottom: BorderSide(
        //     color: Colors.white,
        //   ),
        // ),
        ),
        child : CategoryBackground(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child : Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: (() {
                                    themeCubit.toggleTheme();
                    }),
                    padding: EdgeInsets.only(left : 28),
                     icon: Icon(
                      isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                      color: isDark ? Colors.yellow : Colors.black,
                      size: 25,
                    )
                  ),
                )
              ),
              _buildTitle(context),
              _buildCategories(context)

            ],
          )
        )
        
      );
    }

    Widget _buildTitle(context) {
      return Expanded(
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(28),
          alignment: Alignment.bottomLeft,
          child:  DropdownSearch<Database>(
                    asyncItems : (String? filter) => getData(filter),
                    compareFn : (i , s) => i.isEqual(s),
                    onChanged: (Database? database) {




                        if(database != null){
                          NotionDatabase.userId = database.users;
                          NotionDatabase.schemaId = database.id;
                          NotionDatabase.scheduleId = database.schedule;
                        }



                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text("등록된 데이터가 없습니다 관리자에게 문의해주세요."),
                        //     )
                        // );


                    },
                  ),
          // const Text(
          //   'User Manager Category?',
          //   style: TextStyle(
          //     fontSize: 30,
          //     height: 1.6,
          //     fontWeight: FontWeight.w900,
          //   ),
          // ),
        )
      );
    }

    Future<List<Database>> getData(String? filter) async {
      final List<Database> result = await DatabaseService().schemas();


      if(result.length == 0){
        return [];
      }
      final List<Database> r = Database.fromJsonList(result);
      
      
      return r;
    }

    Widget _buildCategories(BuildContext context) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(28, 42, 28, 62),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 2.6,
          mainAxisSpacing: 15,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {

          //return MenuCard();
          return
            CategoryCard(
                categories[index],
                onPress: () => _onSelectCategory(categories[index])
            );
        },
      );
    }
}

