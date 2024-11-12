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
        title: Text("Controle de Estoque"),
        backgroundColor: Colors.deepPurple[300],
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[250],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "${user!.email}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Usuário'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: signUserOut,
              ),
            ],
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            'Página Home!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ]),

      //floatingActionButton: Container(),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Estoque',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_outlined),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_remove_outlined),
            label: 'Remover',
          ),
        ],
      ),
    );
  }
}
