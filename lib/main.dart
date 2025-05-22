import 'package:e_marketplace_app/auth/forgot_password_screen.dart';
import 'package:e_marketplace_app/auth/signup_multi_step_screen.dart';
import 'package:e_marketplace_app/features/presentation/pages/home_page.dart';
import 'package:e_marketplace_app/auth/login_screen.dart';
import 'package:e_marketplace_app/features/presentation/pages/seller_store_page.dart';
import 'package:flutter/material.dart';
import 'package:e_marketplace_app/features/presentation/pages/main_screen_wrapper.dart'; // <-- NEW: Import the wrapper

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMP Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreenWrapper(),        
        '/login': (context) => const LoginScreen(),
        '/signup': (context) =>  SignupMultiStepScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/seller_store': (context) {
           // Retrieve arguments for the SellerStorePage
           final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
           return SellerStorePage(
             sellerId: args['sellerId'],
             initialProductCategory: args['initialProductCategory'],
             productName: args['productName'],
           );
        },
      },
       // Optional: Define onGenerateRoute for more complex scenarios or dynamic routes
      // onGenerateRoute: (settings) {
      //   // Handle dynamic routes or unknown routes here
      //   return null; // Return null if the route is not handled
      // },
      // --------------------------// Add this route
      
    );
  }
}
