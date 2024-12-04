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
        title: Text('App GW'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w900,
          fontSize: 26,
        ),
      ),

      // Drawer
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Logo e Title
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  "${user!.email}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            // Divider
            Divider(),

            // User Page
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Usuário',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserPage()));
              },
            ),

            // Config Page
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Configurações',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigPage()));
              },
            ),

            //Logoff
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: signUserOut,
            ),
          ],
        ),
      ),

      // Body
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          switch (currentIndex) {
            case 0:
              return StoragePage();
            case 1:
              return AddPage();
            case 2:
              return SearchPage();
            default:
              return Center(
                  child: Column(
                children: [
                  Icon(Icons.home),
                  Text('Bem Vindo!'),
                ],
              ));
          }
        },
      ),

      // BottomBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
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
