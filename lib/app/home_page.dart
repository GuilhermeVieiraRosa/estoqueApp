/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//Componentes

//Paginas

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class HomePage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  final user = FirebaseAuth.instance.currentUser;

  HomePage({super.key});

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Sign User Out Method
  */
  Future<void> signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            'Bem vindo ao aplicativo!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        Center(
          child: Text(
            "${user!.email}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ]),
      //floatingActionButton: Container(),
      //bottomNavigationBar: Container(),
    );
  }
}
