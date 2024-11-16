/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_aplication/app/add_page.dart';
import 'package:flutter_test_aplication/app/config_page.dart';
import 'package:flutter_test_aplication/app/search_page.dart';
import 'package:flutter_test_aplication/app/storage_page.dart';
import 'package:flutter_test_aplication/app/user_page.dart';
//Paginas
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final user = FirebaseAuth.instance.currentUser;

  int currentIndex = 0;

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Sign User Out Method
  */
  Future<void> signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  /**
  * goToPage Method
  */
  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  /**
  * goToPage Method
  */
  void setIndexToUserPage() {
    goToPage(4);
    Navigator.pop(context);
  }

  /**
  * goToPage Method
  */
  void setIndexToConfigPage() {
    goToPage(5);
    Navigator.pop(context);
  }

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text("Controle de Estoque"),
        backgroundColor: Colors.deepPurple[300],
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),

      // Drawer
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
                onTap: () => setIndexToUserPage(),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
                onTap: () => setIndexToConfigPage(),
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

      // Body
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          switch (currentIndex) {
            case 1:
              return AddPage();
            case 2:
              return SearchPage();
            case 4:
              return UserPage();
            case 5:
              return ConfigPage();
            default:
              return StoragePage();
          }
        },
      ),

      // BottomBar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => goToPage(index),
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
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}
