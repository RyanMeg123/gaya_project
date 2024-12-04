import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/splash/views/splash_page1.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gaya_2/providers/user_provider.dart';
import 'package:flutter_gaya_2/services/auth_service.dart';
import 'features/home/controllers/cart_controller.dart';
import 'features/home/home_page.dart';
import 'features/home/detail/product_secondary.dart';
import 'features/home/widgets/product_detail.dart';
import 'models/tab_model.dart';
import 'auth/views/login_page.dart';
import 'auth/views/register_email_page.dart';
import 'features/splash/views/splash_page.dart';
import 'features/home/pages/wishlist_page.dart';
import 'features/home/pages/featured_products_page.dart';
import 'features/home/pages/checkout_page.dart';
import 'features/notification/notification_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String registerEmail = '/register_email';
  static const String homePage = '/home';
  static const String splash = '/';
  static const String productSecondary = '/product_secondary';
  static const String productDetail = '/product_detail';
  static const String wishlist = '/wishlist';
  static const String featuredProducts = '/featured_products';
  static const String checkout = '/checkout';
  static const String notifications = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (!userProvider.hasCheckedLoginState) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await userProvider.initializeUser();
                });
              }

              if (userProvider.isLoggedIn) {
                return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, homePage);
                      });
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, homePage);
                      },
                      child: const SplashPage1(),
                    );
                  },
                );
              }

              return const SplashPage();
            },
          ),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoggedIn) {
                return const HomePage();
              }
              return const LoginPage();
            },
          ),
        );

      case registerEmail:
        return MaterialPageRoute(
          builder: (context) => Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoggedIn) {
                return const HomePage();
              }
              return const RegisterEmailPage();
            },
          ),
        );

      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case productSecondary:
        final args = settings.arguments as ProductRouteParameter;
        return MaterialPageRoute(
          builder: (_) => ProductSecondary(
            productRouteParameter: args,
          ),
        );

      case productDetail:
        final product = settings.arguments as ProductDetail;
        return MaterialPageRoute(
          builder: (context) => ProductDetailWidget(
            product: product,
            cartController: Provider.of<CartController>(context, listen: false),
          ),
        );

      case wishlist:
        return MaterialPageRoute(
          builder: (context) => Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (!userProvider.isLoggedIn) {
                return const LoginPage();
              }
              return const WishlistPage();
            },
          ),
        );

      case featuredProducts:
        return MaterialPageRoute(builder: (_) => const FeaturedProductsPage());

      case checkout:
        final orderItem = settings.arguments as OrderItem;
        return MaterialPageRoute(
          builder: (context) => Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (!userProvider.isLoggedIn) {
                return const LoginPage();
              }
              return CheckoutPage(orderItem: orderItem);
            },
          ),
        );

      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
