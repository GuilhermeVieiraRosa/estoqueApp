/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:flutter/material.dart';
//Paginas
//Componentes
//Tema
import 'package:estoque_app/themes/light_theme.dart';
import 'package:estoque_app/themes/dark_theme.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class ThemeProvider with ChangeNotifier {
  /*********************************************************
  *   Variables
  *********************************************************/

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  /********************************************************* 
  *   Methods
  *********************************************************/

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  /*********************************************************
  *   Build
  *********************************************************/
}
