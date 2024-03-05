import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/main/controllers/home_controller.dart';
import 'feature/main/controllers/item_controller.dart';
import 'feature/main/presentation/pages/home_page.dart';
import 'feature/main/presentation/pages/item_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => ItemController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRUD and MVVM',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/product_form': (context) => const ItemAdd(),
        },
      ),
    );
  }
}
