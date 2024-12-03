import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'advanced_ecommerce/provider/filter_provider.dart';
import 'advanced_ecommerce/product_list_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterAndSortProducts()),
      ],
      child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const DebuggingTask(),
      home:  const ProductListScreen(),
    );
  }
}

