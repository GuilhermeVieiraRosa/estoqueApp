/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:flutter/material.dart';

// Componentes

// Paginas
import 'package:flutter_test_aplication/app/login_page.dart';
import 'package:flutter_test_aplication/app/register_page.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class LoginOrRegisterPage extends StatefulWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  LoginOrRegisterPage({super.key});

  /*********************************************************
  *   Create State
  *********************************************************/

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
      return LoginPage(onTap: chooseBetweenLoginOrRegisterPage);
    } else {
      return RegisterPage(onTap: chooseBetweenLoginOrRegisterPage);
    }
  }
}
