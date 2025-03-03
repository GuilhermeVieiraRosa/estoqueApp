/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//Paginas
import 'package:estoque_app/app/home_page.dart';
import 'package:estoque_app/app/login_or_register_page.dart';
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class AuthPage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  const AuthPage({super.key});

  /*********************************************************
  *   Methods
  *********************************************************/

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is Logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // User not Logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
