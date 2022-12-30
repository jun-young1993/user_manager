import 'package:user_manager/domain/entities/category.dart';
import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/routes.dart';

class CategoryNames {
  static const String user = "사용자";
  static const String calendar = "갤린더";
  static const String config = "설정";
}

const List<Category> categories = [
  // Category(name: 'home1', color: AppColors.teal, route: Routes.home),
  Category(name: CategoryNames.user, color: AppColors.red, route: Routes.user),
  Category(
      name: CategoryNames.calendar,
      color: AppColors.blue,
      route: Routes.calendar),
  Category(
      name: CategoryNames.config, color: AppColors.brown, route: Routes.config),
  // Category(name: 'home4', color: AppColors.yellow, route: Routes.home),
  // Category(name: 'home5', color: AppColors.purple, route: Routes.home),
  // Category(name: '설정', color: AppColors.brown, route: Routes.config),
];
