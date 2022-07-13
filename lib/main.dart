import 'package:etsy_uy/screens/inicio.dart';
import 'package:etsy_uy/services/services.dart';
import 'package:flutter/material.dart';
import 'package:etsy_uy/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());
  
  class AppState extends StatelessWidget {
  const AppState ({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> ProductsService())
        ],
        child: const MyApp(),
      );
    }
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'etsy uy',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'inicio': (_) => const Inicio(),
        'home': (_) => const HomeScreen(),
        'list products': (_) => const ListProduct()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 164, 84, 10),
          elevation: 0,
        )
      ),
    );
  }
}
