import 'package:flutter/material.dart';
import 'package:user_manager/domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final void Function()? onPress;
  const CategoryCard(
    this.category,{
    this.onPress
  });
    @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        final itemWidth = constrains.maxWidth;
      }
    );
  }

}
 