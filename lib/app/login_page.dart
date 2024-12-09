/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/themes/theme_provider.dart';
// Paginas
// Componentes
import 'package:estoque_app/ui/button_component.dart';
import 'package:estoque_app/ui/textfield_component.dart';
import 'package:provider/provider.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class LoginPage extends StatefulWidget {
  void Function()? onRegisterButtomTap;

  LoginPage({
    super.key,
    required this.onRegisterButtomTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Sign In Method
  */
  Future<void> signUserIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try Sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Remove loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Remove loading circle
      Navigator.pop(context);

      // Show Error Message
      showErrorMessage(e.code);
    }
  }

  /**
  * Error Message Method
  */
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Arredondamento dos cantos
            side: const BorderSide(
              color: Colors.grey, // Cor da borda
              width: 3, // Espessura da borda
            ),
          ),
        );
      },
    );
  }

  /*********************************************************
  *   Build
  *********************************************************/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Central Icon and Theme Icon
                Stack(
                  children: [
                    // Central Icon
                    Center(
                      child: Icon(
                        Icons.account_box,
                        size: 180,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    // Theme Toggle Button
                    Positioned(
                      top: 15,
                      right: 15,
                      child: GestureDetector(
                        onTap: () => Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleTheme(),
                        child: Icon(
                          Icons.sunny,
                          size: 40,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                  ],
                ),

                // Text
                const SizedBox(height: 5),
                Column(
                  children: [
                    Text(
                      'App GW',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Entrar na conta',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // Username Text Field
                const SizedBox(height: 10),
                MyTextfieldComponent(
                  controller: emailController,
                  hintText: 'Usuário',
                  obscureText: true,
                ),

                // Password Text Field
                const SizedBox(height: 10),
                MyTextfieldComponent(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                // Login Button
                const SizedBox(height: 25),
                MyButtonComponent(
                  onTap: signUserIn,
                  text: 'Logar',
                ),

                // // Forgot Password
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 25),
                //       child: Text('Esqueceu a senha?'),
                //     ),
                //   ],
                // ),

                // Register Button
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: widget.onRegisterButtomTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem uma conta? ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const Text(
                        'Registre-se aqui.',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // A implementar:
                // Remain Connected
                // Google + Apple sign
              ],
            ),
          ),
        ),
      ),
    );
  }
}
