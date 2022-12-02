import 'package:flutter/material.dart';
import 'package:user_manager/config/constants.dart';
import 'package:user_manager/config/images.dart';
import 'package:user_manager/ui/widgets/menu_background.dart';
part '../home/sections/header_card_content.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final ScrollController _scrollController = ScrollController();


    bool showTitle = false;

    @override
    void initState() {
        _scrollController.addListener(_onScroll);
      super.initState();
    }
     @override
      void dispose() {
        _scrollController.dispose();

        super.dispose();
      }

      void _onScroll() {
        if (!_scrollController.hasClients) return;

        final offset = _scrollController.offset;
        final showTitle = offset > _HeaderCardContent.height - kToolbarHeight;

        // Prevent unneccesary rebuild
        if (this.showTitle == showTitle) return;

        setState(() {
          this.showTitle = showTitle;
        });
      }
      
    @override
    Widget build(BuildContext context){
      return Scaffold(
          body : NestedScrollView(
               controller: _scrollController,
               headerSliverBuilder: (_, __) => [
                SliverAppBar(
                    expandedHeight: 582,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                       title:  Visibility(
                          visible: showTitle,
                          child: const Text(
                            AppConstants.name,
                          )
                       ),
                       background : _HeaderCardContent()
                    ), 
                )
               ],
               body : Text('HI')
          )
      );
    }
}