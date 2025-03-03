/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:flutter/material.dart';
// Paginas
import 'package:estoque_app/app/login_page.dart';
import 'package:estoque_app/app/register_page.dart';
// Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

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
