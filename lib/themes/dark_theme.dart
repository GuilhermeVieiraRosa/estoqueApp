/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:flutter/material.dart';
//Paginas
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    //Fundo (Tema Principal)
    surface: const Color.fromARGB(255, 30, 30, 30),
    inverseSurface: Colors.orange.shade50,
    //Primaria
    primary: Colors.white,
    inversePrimary: Colors.orange.shade700,
    //Secundária
    secondary: const Color.fromARGB(255, 60, 60, 60),
    //Terciária (Texto - Contrário a Surface)
    tertiary: Colors.white,
  ),
);
