import '../presentation/screens/admin/stores/add_store_screen.dart';

import '../presentation/screens/admin/stores/admin_stores_screen.dart';
import '../presentation/screens/login/resest_passwrod_screen.dart';

import '../presentation/screens/admin/add_new_product/add_product_screen.dart';
import '../presentation/screens/admin/products_list/admin_products_list_screen.dart';

import '../presentation/screens/admin/home/admin_home_screen.dart';

import '../presentation/screens/user/all_products/all_products_screen.dart';

import '../presentation/screens/user/home/user_home_screen.dart';

import '../presentation/screens/Login/login_screen.dart';
import '../presentation/screens/signup/signup_screen.dart';
import '../presentation/screens/user/stores/user_stores_screen.dart';

final routes = {
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  UserHomeScreen.routeName: (context) => const UserHomeScreen(),
  AllProductsScreen.routeName: (context) => const AllProductsScreen(),
  AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
  AdminProductsListScreen.routeName: (context) =>
      const AdminProductsListScreen(),
  AddNewProductScreen.routeName: (context) => const AddNewProductScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  AdminStoresScreen.routeName: (context) => const AdminStoresScreen(),
  UserStoresScreen.routeName: (context) => const UserStoresScreen(),
  AddNewStoreScreen.routeName: (context) => const AddNewStoreScreen(),
};
