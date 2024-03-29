import 'dart:developer';
import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/domain/entities/database.dart';
import 'package:user_manager/service/database_service.dart';
import 'package:user_manager/states/theme/theme_cubit.dart';
import 'package:user_manager/ui/widgets/category_background.dart';
import 'package:user_manager/domain/entities/category.dart';
import 'package:user_manager/ui/widgets/category_card.dart';
import 'package:user_manager/data/categories.dart';
import 'package:user_manager/routes.dart';
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
               body : Text('home')
          )
      );
    }
}