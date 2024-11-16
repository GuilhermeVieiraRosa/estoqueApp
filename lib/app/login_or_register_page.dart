/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:flutter/material.dart';
// Paginas
import 'package:flutter_test_aplication/app/login_page.dart';
import 'package:flutter_test_aplication/app/register_page.dart';
// Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  bool showLoginPage = true;

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Choose Page Method
  */
  void chooseBetweenLoginOrRegisterPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  /*********************************************************
  *   Build
  *********************************************************/
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onRegisterButtomTap: chooseBetweenLoginOrRegisterPage);
    } else {
      return RegisterPage(onLoginButtomTap: chooseBetweenLoginOrRegisterPage);
    }
  }
}
