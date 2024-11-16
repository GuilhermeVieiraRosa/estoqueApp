/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//Paginas
import 'package:flutter_test_aplication/app/auth_page.dart';
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
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /**
  * RunApp
  */
  runApp(MyApp());
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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: AuthPage(),
    );
  }
}
