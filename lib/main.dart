/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//Componentes

//Paginas
import 'package:flutter_test_aplication/app/auth_page.dart';

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
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Armazem App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: AuthPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}
