import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Providers & Controllers
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'features/home/controllers/cart_controller.dart';
import 'features/home/controllers/wishlist_controller.dart';
import 'controllers/home_controller.dart';
import 'providers/transaction_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/notification_provider.dart';

// Routes
import 'routes.dart';

// 添加全局 navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<CartController>(
          create: (_) => CartController(),
        ),
        ChangeNotifierProvider<WishlistController>(
          create: (_) => WishlistController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProxyProvider<UserProvider, ProfileProvider>(
          create: (_) => ProfileProvider(),
          update: (context, userProvider, previous) {
            if (userProvider.userId != null) {
              print(
                  'ProxyProvider: Loading profile for user ${userProvider.userId}');
              previous?.loadUserProfile(userProvider.userId!);
            }
            return previous ?? ProfileProvider();
          },
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (_) => NotificationProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey, // 添加 navigator key
            title: 'Gaya App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              // 可以添加其他主题配置
            ),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    ),
  );
}
