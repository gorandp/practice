import 'dart:ffi';

demoVariables(){
  // - Todo son objectos en Dart.
  // - Todas las variables contienen referencias a objetos.
  // - Las variables solo pueden referirse a objetos del tipo concordante
  int n = 3;
  double x = 0.05;
  String s = "hola";
  bool b = false;

  print(n);
  print(x);
  print(s);
  print(b);

  String s2 = 'hola2';
  String comilla_simple = "'";
  String comilla_doble = '"';
  int a; // será null

  print(s2);
  print(comilla_simple);
  print(comilla_doble);
  print(a);
}

demoVarDynamicNum(){

  // al poner 'var' se infiere el tipo (del literal o del tipo de retorno, etc)
  var a = 7.0;
  // Existe un tipo especial para "cualquier cosa"
  var b; // dynamic
  dynamic c;
  b = 5;
  b = 'a';
  c = "23423";
  c = 0.06;
  print(a);
  print(b);
  print(c);

  // num es "numerico" y es tipo base de 'double' y 'int'
  num x = 7;
  num y = c;
  print(x);
  print(y);

}

demoConversion(){
  // conversión numérico -> string
  int a = 5;
  double b = 3.1415;

  String sa = a.toString();
  String sb = b.toString();
  String sc = 546.toString();

  print(sa);
  print(sb);
  print(sc);

  // conversión string a número
  String sd = '954';
  String se = '2.78';
  int d = int.parse(sd);
  double e = double.parse(se);
  print(d);
  print(e);
}

interpolacionStrings(){
  // Interpolación de strings
  int pesos = 4;
  String mensaje = "Faltan ${pesos+1} pe pa compra ese vi";
  pesos += 1;
  mensaje = "Faltan $pesos pe pa compra ese vi"; // sin las llaves
  print(mensaje);
}

stringLargos(){
  // Literales de string seguidos se pegan
  var texto = 'En un lugar de la mancha '
    'de cuyo nombre no queiro acordarme '
    'vivía un hidalgo...';

  // el + junta strings
  var s = 'James ' + 'Bond';

  // Literal multilínea
  var texto2 = """
Un texto largo con varias líneas
  Esta es la segunda
    Y esta es la tercera""";

  print(texto);
  print(texto2);
  print(s);
}

condicionesBooleanas(){
  // En un 'if' solo pueden ir 'bool' o bien 'dynamic' (que debería ser 'bool')
  var a;
  if (a != null) {
    print("a no es null");
  }

  var s = '';
  if (s.isEmpty) {
    print("s está vacío");
  }
}

demoListas(){
  List<int> primos = [2, 3, 5, 7, 11, 13];
  List<dynamic> cosas = [2, true, 'hola', 2.15, [], null];
  var cosas2 = [2, true, 'hola'];
  print(primos);
  print(cosas);
  print(cosas);
  
  var nums = [1, 2, 3];
  nums.add(4);
  // nums.add('5'); no se puede agregar un elemento que no sea entero, infiere que es una lista de enteros
  print(nums);

  print(primos.length);
  print(cosas.length);
  print(cosas2.length);
  print(nums.length);

  // cómo determinar el tipo de un literal cuando no hay una variable
  var palabras = <String>[];
  // palabras.add(5); no se puede agregar un 'int' a una lista de 'String'
  palabras.add('palabrita');


  // Acceder a las casillas de una lista (como en C, C++, Java, Javascript, etc.)
  print(primos[1]);
  print(nums[nums.length-1]); // ultimo elemento
  print(cosas[2]);
}

collectionIfFor(){
  bool larga = false;
  var L = [
    1,
    2,
    3,
    if (larga) 4,
    5
  ];
  // if (larga) {
  //   L.add(4);
  // }
  print(L);


  int max = 10;
  var M = [-1, for (int i = 0; i < max; i++) i+1, 1]; // se pueden meter expresiones dentro de las lsitas
  // for (int i = 0; i < max; i++) {
  //   M.add(i+1);
  // }
  print(M);
}

demoSets(){
  Set<int> primos = {2, 3, 5, 7, 11, 13};
  Set<dynamic> cosas = {null, 'cosa1', 3, true, [1, 3]};
  var numeros = {1, 2, 3, 4};

  Set<String> conjunto_vacio = {};
  var map_vacio = {}; // esto es un map!!!
  var conjunto_string_vacio = <String>{}; // Esto es un Set<String>

  print(primos);
  print(cosas);
  print(numeros);

  numeros.add(5);
  numeros.addAll({6, 7, 8 , 9});
  numeros.addAll([10, 11, 12, 13]);

  if(numeros.contains(13)){
    print("tiene 13!!");
  }

  print(numeros);
  print(numeros.length);
}

demoMaps() {
  var M = {
    'nombre': 'James',
    'apellido': 'Bond',
    'edad': 27
  };
  Map<int, String> numeros = {
    1: 'uno',
    2: 'dos',
    3: 'tres'
  };
  Map<dynamic, dynamic> cosas = {
    2: 'dos',
    'dos': 2,
    true: 'verdad',
    'falso': false
  };
  print(M);
  print(numeros);

  print(numeros[3]);
  print(numeros[4]);

  numeros[5] = 'cinco';
  print(numeros);

  print(cosas);
  print(cosas.length);
  print(numeros.length);

  cosas.addAll(numeros);
  print(cosas);
}

void main() {
}
