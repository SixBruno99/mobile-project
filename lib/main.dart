import 'package:flutter/material.dart';
import 'package:mobile_project/repositorie/user_id.dart';
import 'package:provider/provider.dart';

import 'widgets/login/login.dart';

void main() {
  runApp(MultiProvider(
          providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
