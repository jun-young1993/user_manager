
import 'package:user_manager/domain/entities/category.dart';
import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/routes.dart';
const List<Category> categories = [
  Category(name: 'home1', color: AppColors.teal, route: Routes.home),
  Category(name: '사용자', color: AppColors.red, route: Routes.user),
  Category(name: 'home3', color: AppColors.blue, route: Routes.home),
  Category(name: 'home4', color: AppColors.yellow, route: Routes.home),
  Category(name: 'home5', color: AppColors.purple, route: Routes.home),
  Category(name: '설정', color: AppColors.brown, route: Routes.config),
];
