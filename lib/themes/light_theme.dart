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

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    //Fundo (Tema Principal)
    surface: Colors.grey.shade100,
    inverseSurface: Colors.orange.shade400,
    //Primaria
    primary: Colors.white,
    inversePrimary: Colors.orange.shade600,
    //Secundária
    secondary: Colors.white,
    //Terciária (Texto - Contrário a Surface)
    tertiary: Colors.black,
  ),
);
