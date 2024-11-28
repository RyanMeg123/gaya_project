import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final authService = AuthService();
    
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => FutureBuilder<bool>(
            future: authService.isLoggedInValid(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashPage();
              }
              
              if (snapshot.data == true) {
                return const HomePage();
              }
              
              return const SplashPage();
            },
          ),
        );

      case login:
      case registerEmail:
        return MaterialPageRoute(
          builder: (context) => FutureBuilder<bool>(
            future: authService.isLoggedInValid(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (snapshot.data == true) {
                return const HomePage();
              }
              
              return settings.name == login 
                  ? const LoginPage() 
                  : const RegisterEmailPage();
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
        return MaterialPageRoute(builder: (_) => const WishlistPage());
      case featuredProducts:
        return MaterialPageRoute(builder: (_) => const FeaturedProductsPage());
      case checkout:
        final orderItem = settings.arguments as OrderItem;
        return MaterialPageRoute(
          builder: (context) => CheckoutPage(orderItem: orderItem),
        );
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
