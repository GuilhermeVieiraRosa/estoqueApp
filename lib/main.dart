/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:estoque_app/services/business_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:estoque_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
//Paginas
import 'package:estoque_app/app/auth_page.dart';
//Componentes

/***********************************************************************************************************************
* 
*                                                  Main
* 
***********************************************************************************************************************/

Future<void> main() async {
  /**
  * Firebase Configuration
  */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "estoqueApp",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /**
  * RunApp
  */
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
}

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyApp extends StatelessWidget {
  /*********************************************************
   *   Variables
   *********************************************************/

  const MyApp({super.key});

  /*********************************************************
  *   Methods
  *********************************************************/

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armazem App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
