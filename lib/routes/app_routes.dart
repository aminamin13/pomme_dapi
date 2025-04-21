import 'package:get/get.dart';
import 'package:pomme_dapi/features/authentication/screens/login/login.dart';
import 'package:pomme_dapi/features/authentication/screens/onboarding/onboarding.dart';
import 'package:pomme_dapi/features/authentication/screens/password_config/forget_password.dart';
import 'package:pomme_dapi/features/authentication/screens/signup/signup.dart';
import 'package:pomme_dapi/features/authentication/screens/signup/verify_email.dart';
import 'package:pomme_dapi/features/personalization/screens/address/address.dart';
import 'package:pomme_dapi/features/personalization/screens/profile/profile_screen.dart';
import 'package:pomme_dapi/features/personalization/screens/settings/settings_screen.dart';
import 'package:pomme_dapi/features/shop/screens/cart/cart.dart';
import 'package:pomme_dapi/features/shop/screens/checkout/checkout.dart';
import 'package:pomme_dapi/features/shop/screens/home/homescreen.dart';
import 'package:pomme_dapi/features/shop/screens/orders/order.dart';
import 'package:pomme_dapi/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:pomme_dapi/features/shop/screens/search_page/search_product.dart';
import 'package:pomme_dapi/features/shop/screens/store/storescreen.dart';
import 'package:pomme_dapi/features/shop/screens/wishlist/wishlist.dart';
import 'package:pomme_dapi/routes/routes.dart';

class AppRoutes {
  static final page = [
    GetPage(name: AllRoutes.home, page: () => const Homescreen()),
    GetPage(name: AllRoutes.store, page: () => const StoreScreen()),
    GetPage(name: AllRoutes.favourites, page: () => const WishListScreen()),
    GetPage(name: AllRoutes.settings, page: () => const SettingsScreen()),
    GetPage(
      name: AllRoutes.productReviews,
      page: () => const ProductReviewsScreen(),
    ),
    GetPage(name: AllRoutes.order, page: () => const OrderScreen()),
    GetPage(name: AllRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: AllRoutes.cart, page: () => const CartScreen()),
    GetPage(name: AllRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: AllRoutes.userAddress, page: () => const AddressScreen()),
    GetPage(name: AllRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: AllRoutes.verifyEmail, page: () => const verifyEmailScreen()),
    GetPage(name: AllRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
      name: AllRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(name: AllRoutes.onBoarding, page: () => const OnboardingScreen()),
    GetPage(name: AllRoutes.searchProducts, page: () => const SearchProducts()),
  ];
}
