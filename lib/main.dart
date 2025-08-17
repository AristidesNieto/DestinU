import 'package:flutter/material.dart';
//import 'topics.dart'; // Importa el nuevo archivo
import 'package:fl_chart/fl_chart.dart';
import 'services/api_service.dart';
import 'dart:math';
import 'topics.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // <-- Aquí inicia con LoginPage
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00171F),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    if (!value.contains('@')) {
                      return 'Correo no válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    if (value.length < 4) {
                      return 'Mínimo 5 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    /*if (_formKey.currentState!.validate()) {
                      try {
                        final usuario = await ApiService.iniciarSesion(
                          emailController.text,
                          passwordController.text,
                        );
                        print('Usuario encontrado: $usuario');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Inicio de sesión exitoso')),
                        );
                        // Navega a la pantalla principal o HomePage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } catch (e) {
                        print('Error en el inicio de sesión: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('CTM')),
                        );
                      }
                    }*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFFFFF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 25, color: Color(0xff003459)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'nombre de la app')),
                    );
                  },
                  child: const Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xff00171F),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Registro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    if (!value.contains('@')) {
                      return 'Correo no válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    if (value.length < 5) {
                      return 'Mínimo 5 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final resultado = await ApiService.registrarUsuario(
                          emailController.text,
                          passwordController.text,
                        );
                        print('Usuario registrado: $resultado');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro exitoso')),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                        // Navega a la pantalla de preguntas (QuizPage)
                      } catch (e) {
                        print('Error en el registro: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error en el registro')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFFFFF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 25, color: Color(0xff003459)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    '¿Ya tienes una sesión? Inicia sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffADEBFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Queremos conocerte!',
              style: TextStyle(fontSize: 28, color: Color(0xff00171F)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 133, 225, 255),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Tomar prueba',
                  style: TextStyle(
                    color: Color(0xff00171F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// Definición de las preguntas y sus opciones
class Pregunta {
  final String texto;
  final List<Opcion> opciones;

  Pregunta({required this.texto, required this.opciones});
}

class Opcion {
  final String texto;
  final Map<String, int> puntuacion;

  Opcion({required this.texto, required this.puntuacion});
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Mapa para guardar las puntuaciones de cada área
  final Map<String, int> _puntuaciones = {
    "Humanidades": 0,
    "Ingeniería y Tecnología": 0,
    "Ciencias sociales": 0,
    "Ciencias de la salud": 0,
    "Administración y negocios": 0,
    "Arte y Arquitectura": 0,
    "Educación": 0,
    "Ciencias agropecuarias": 0,
    "Ciencias Exactas": 0,
  };

  // Mapa para guardar la opción seleccionada por cada pregunta
  final Map<int, Opcion?> _respuestasSeleccionadas = {};

  final List<Pregunta> _preguntas = [
    // Pregunta 1
    Pregunta(
      texto: "Si tuvieras que elegir un pasatiempo, ¿cuál sería?",
      opciones: [
        Opcion(
            texto: "Escribir un blog sobre historia o literatura.",
            puntuacion: {"Humanidades": 3, "Ciencias sociales": 1}),
        Opcion(
            texto: "Desarmar un electrodoméstico para entender cómo funciona.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Ciencias Exactas": 1}),
        Opcion(
            texto: "Participar en un debate político o social.",
            puntuacion: {
              "Ciencias sociales": 3,
              "Administración y negocios": 2
            }),
      ],
    ),
    // Pregunta 2
    Pregunta(
      texto: "¿Qué tipo de libros te gusta más leer?",
      opciones: [
        Opcion(
            texto: "Biografías de personajes históricos o ensayos filosóficos.",
            puntuacion: {"Humanidades": 3, "Ciencias sociales": 1}),
        Opcion(
            texto:
                "Artículos sobre nuevos descubrimientos científicos o avances tecnológicos.",
            puntuacion: {"Ciencias Exactas": 3, "Ingeniería y Tecnología": 2}),
        Opcion(
            texto: "Novelas de ficción o poesía.",
            puntuacion: {"Arte y Arquitectura": 3, "Humanidades": 1}),
      ],
    ),
    // Pregunta 3
    Pregunta(
      texto:
          "Si te pidieran resolver un problema en tu trabajo, ¿qué enfoque usarías?",
      opciones: [
        Opcion(
            texto: "Diseñar un sistema lógico y metódico para solucionarlo.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto: "Entender el impacto del problema en las personas.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias sociales": 2}),
        Opcion(
            texto:
                "Buscar una solución que sea estéticamente atractiva y funcional.",
            puntuacion: {
              "Arte y Arquitectura": 3,
              "Ingeniería y Tecnología": 1
            }),
      ],
    ),
    // Pregunta 4
    Pregunta(
      texto: "En un equipo, prefieres ser la persona que:",
      opciones: [
        Opcion(
            texto: "Lidera la estrategia y gestiona los recursos.",
            puntuacion: {
              "Administración y negocios": 3,
              "Ciencias sociales": 1
            }),
        Opcion(
            texto: "Se encarga de la investigación y la experimentación.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto: "Comunica y enseña los nuevos procesos a los demás.",
            puntuacion: {"Educación": 3, "Ciencias sociales": 2}),
      ],
    ),
    // Pregunta 5
    Pregunta(
      texto: "¿Qué te parece más interesante?",
      opciones: [
        Opcion(
            texto:
                "Analizar grandes conjuntos de datos para encontrar patrones.",
            puntuacion: {"Ciencias Exactas": 3, "Ingeniería y Tecnología": 2}),
        Opcion(
            texto: "Trabajar en un hospital ayudando a los pacientes.",
            puntuacion: {"Ciencias de la salud": 3}),
        Opcion(
            texto: "Supervisar una granja y sus cultivos.",
            puntuacion: {"Ciencias agropecuarias": 3}),
      ],
    ),
    // Pregunta 6
    Pregunta(
      texto: "En tu tiempo libre, ¿qué actividad te atrae más?",
      opciones: [
        Opcion(
            texto: "Dibujar, pintar o esculpir.",
            puntuacion: {"Arte y Arquitectura": 3}),
        Opcion(
            texto: "Ser voluntario en una escuela.",
            puntuacion: {"Educación": 3, "Ciencias sociales": 2}),
        Opcion(
            texto: "Crear un plan de negocios para una idea que tienes.",
            puntuacion: {
              "Administración y negocios": 3,
              "Ingeniería y Tecnología": 1
            }),
      ],
    ),
    // Pregunta 7
    Pregunta(
      texto: "Si tuvieras que diseñar un proyecto, ¿qué te entusiasmaría más?",
      opciones: [
        Opcion(
            texto: "Construir un prototipo de un dispositivo electrónico.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
        Opcion(
            texto: "Preparar una clase o taller sobre un tema que dominas.",
            puntuacion: {"Educación": 3}),
        Opcion(
            texto: "Investigar los efectos de un pesticida en un ecosistema.",
            puntuacion: {"Ciencias agropecuarias": 3, "Ciencias Exactas": 2}),
      ],
    ),
    // Pregunta 8
    Pregunta(
      texto: "Te sientes más cómodo trabajando con:",
      opciones: [
        Opcion(
            texto: "Números, ecuaciones y fórmulas.",
            puntuacion: {"Ciencias Exactas": 3, "Ingeniería y Tecnología": 1}),
        Opcion(
            texto: "Herramientas, máquinas y tecnología.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Ciencias Exactas": 1}),
        Opcion(
            texto: "Personas, ideas y conceptos abstractos.",
            puntuacion: {"Humanidades": 3, "Ciencias sociales": 2}),
      ],
    ),
    // Pregunta 9
    Pregunta(
      texto: "¿Qué tipo de problema prefieres resolver?",
      opciones: [
        Opcion(
            texto: "Un problema de comunicación entre un equipo.",
            puntuacion: {
              "Ciencias sociales": 3,
              "Administración y negocios": 2
            }),
        Opcion(
            texto: "Un problema de programación o desarrollo de software.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto: "Un problema relacionado con la salud de una persona.",
            puntuacion: {"Ciencias de la salud": 3}),
      ],
    ),
    // Pregunta 10
    Pregunta(
      texto: "Si pudieras aprender una nueva habilidad, ¿cuál elegirías?",
      opciones: [
        Opcion(texto: "Negociación y liderazgo.", puntuacion: {
          "Administración y negocios": 3,
          "Ciencias sociales": 1
        }),
        Opcion(
            texto: "Diseño gráfico o arquitectura de interiores.",
            puntuacion: {"Arte y Arquitectura": 3}),
        Opcion(
            texto: "Química orgánica o física cuántica.",
            puntuacion: {"Ciencias Exactas": 3}),
      ],
    ),
    // Pregunta 11
    Pregunta(
      texto: "En una exposición de arte, te detienes más a observar:",
      opciones: [
        Opcion(
            texto: "Las técnicas y la historia detrás de las obras.",
            puntuacion: {"Arte y Arquitectura": 3, "Humanidades": 2}),
        Opcion(
            texto: "El impacto social o político que representan.",
            puntuacion: {"Ciencias sociales": 3}),
        Opcion(
            texto: "La estructura matemática y las proporciones de las obras.",
            puntuacion: {"Ciencias Exactas": 3, "Arte y Arquitectura": 1}),
      ],
    ),
    // Pregunta 12
    Pregunta(
      texto: "¿Qué trabajo de voluntariado te resultaría más gratificante?",
      opciones: [
        Opcion(
            texto: "Enseñar a leer a niños o adultos.",
            puntuacion: {"Educación": 3, "Humanidades": 1}),
        Opcion(
            texto: "Cuidar de animales o plantas en una reserva natural.",
            puntuacion: {"Ciencias agropecuarias": 3}),
        Opcion(texto: "Recaudar fondos para una causa social.", puntuacion: {
          "Administración y negocios": 3,
          "Ciencias sociales": 2
        }),
      ],
    ),
    // Pregunta 13
    Pregunta(
      texto: "Si te regalaran un curso, ¿cuál elegirías?",
      opciones: [
        Opcion(
            texto: "Un curso de escritura creativa.",
            puntuacion: {"Humanidades": 3}),
        Opcion(
            texto: "Un curso de robótica.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
        Opcion(
            texto: "Un curso de nutrición.",
            puntuacion: {"Ciencias de la salud": 3}),
      ],
    ),
    // Pregunta 14
    Pregunta(
      texto: "Te sientes más motivado por:",
      opciones: [
        Opcion(
            texto: "La posibilidad de crear algo nuevo y tangible.",
            puntuacion: {
              "Ingeniería y Tecnología": 3,
              "Arte y Arquitectura": 2
            }),
        Opcion(
            texto: "La oportunidad de ayudar a los demás.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias sociales": 2}),
        Opcion(
            texto: "El desafío intelectual de resolver un enigma.",
            puntuacion: {"Ciencias Exactas": 3}),
      ],
    ),
    // Pregunta 15
    Pregunta(
      texto: "¿Qué prefieres hacer en un fin de semana lluvioso?",
      opciones: [
        Opcion(
            texto: "Leer un libro sobre filosofía o mitología.",
            puntuacion: {"Humanidades": 3}),
        Opcion(
            texto: "Armar un mueble o reparar algo en casa.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
        Opcion(
            texto: "Planificar tu presupuesto o un viaje.",
            puntuacion: {"Administración y negocios": 3}),
      ],
    ),
    // Pregunta 16
    Pregunta(
      texto: "En una película, te interesa más:",
      opciones: [
        Opcion(
            texto: "El desarrollo de los personajes y el guion.",
            puntuacion: {"Humanidades": 3, "Ciencias sociales": 1}),
        Opcion(
            texto: "La tecnología utilizada en los efectos especiales.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
        Opcion(
            texto: "La dirección de arte y la fotografía.",
            puntuacion: {"Arte y Arquitectura": 3}),
      ],
    ),
    // Pregunta 17
    Pregunta(
      texto:
          "Si tuvieras un millón de dólares para un proyecto social, ¿a qué lo destinarías?",
      opciones: [
        Opcion(
            texto: "A financiar investigación sobre una enfermedad.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto:
                "A construir un centro de capacitación para personas sin empleo.",
            puntuacion: {"Educación": 3, "Administración y negocios": 2}),
        Opcion(
            texto: "A un proyecto para preservar la vida silvestre.",
            puntuacion: {"Ciencias agropecuarias": 3, "Ciencias Exactas": 1}),
      ],
    ),
    // Pregunta 18
    Pregunta(
      texto: "¿Qué te parece más un desafío?",
      opciones: [
        Opcion(
            texto: "Entender el comportamiento humano.",
            puntuacion: {"Ciencias sociales": 3, "Ciencias de la salud": 2}),
        Opcion(
            texto: "Demostrar un teorema matemático complejo.",
            puntuacion: {"Ciencias Exactas": 3}),
        Opcion(
            texto: "Escribir un poema o una obra de teatro.",
            puntuacion: {"Humanidades": 3, "Arte y Arquitectura": 1}),
      ],
    ),
    // Pregunta 19
    Pregunta(
      texto: "Cuando viajas, ¿qué tipo de lugar visitas con mayor frecuencia?",
      opciones: [
        Opcion(
            texto: "Museos y sitios históricos.",
            puntuacion: {"Humanidades": 3, "Arte y Arquitectura": 2}),
        Opcion(
            texto: "Universidades y centros de investigación.",
            puntuacion: {"Ciencias Exactas": 3}),
        Opcion(
            texto: "Zonas rurales y granjas.",
            puntuacion: {"Ciencias agropecuarias": 3}),
      ],
    ),
    // Pregunta 20
    Pregunta(
      texto:
          "Si tuvieras que pasar un día entero haciendo solo una cosa, ¿qué elegirías?",
      opciones: [
        Opcion(
            texto: "Cuidar de jardines y cultivos.",
            puntuacion: {"Ciencias agropecuarias": 3}),
        Opcion(
            texto: "Ayudar a la gente a organizar sus finanzas.",
            puntuacion: {"Administración y negocios": 3}),
        Opcion(
            texto: "Estudiar cómo funciona el cerebro humano.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias Exactas": 2}),
      ],
    ),
    // Pregunta 21
    Pregunta(
      texto: "¿Qué prefieres enseñar a alguien?",
      opciones: [
        Opcion(
            texto: "Una nueva técnica de dibujo.",
            puntuacion: {"Arte y Arquitectura": 3, "Educación": 2}),
        Opcion(
            texto: "Cómo usar un nuevo programa de computadora.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Educación": 2}),
        Opcion(
            texto: "La importancia de la empatía.",
            puntuacion: {"Ciencias sociales": 3, "Educación": 2}),
      ],
    ),
    // Pregunta 22
    Pregunta(
      texto:
          "En una sala llena de gente, ¿qué conversación te interesaría más?",
      opciones: [
        Opcion(texto: "Una sobre la situación económica global.", puntuacion: {
          "Administración y negocios": 3,
          "Ciencias sociales": 2
        }),
        Opcion(
            texto: "Una sobre los últimos avances en la cura del cáncer.",
            puntuacion: {"Ciencias de la salud": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto: "Una sobre el significado de una novela clásica.",
            puntuacion: {"Humanidades": 3}),
      ],
    ),
    // Pregunta 23
    Pregunta(
      texto: "¿Cuál de estos escenarios te parece más emocionante?",
      opciones: [
        Opcion(
            texto: "Inventar una nueva máquina.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
        Opcion(
            texto: "Descubrir una nueva especie de planta.",
            puntuacion: {"Ciencias agropecuarias": 3, "Ciencias Exactas": 2}),
        Opcion(
            texto: "Escribir el discurso que cambiará una campaña política.",
            puntuacion: {"Ciencias sociales": 3, "Humanidades": 2}),
      ],
    ),
    // Pregunta 24
    Pregunta(
      texto: "Si tuvieras que investigar, ¿qué tema elegirías?",
      opciones: [
        Opcion(
            texto: "La historia de las civilizaciones antiguas.",
            puntuacion: {"Humanidades": 3}),
        Opcion(
            texto: "El comportamiento de los mercados financieros.",
            puntuacion: {"Administración y negocios": 3}),
        Opcion(
            texto: "Las propiedades de los elementos químicos.",
            puntuacion: {"Ciencias Exactas": 3}),
      ],
    ),
    // Pregunta 25
    Pregunta(
      texto: "En un proyecto de construcción, ¿qué tarea te atrae más?",
      opciones: [
        Opcion(texto: "Diseñar los planos y la estructura.", puntuacion: {
          "Arte y Arquitectura": 3,
          "Ingeniería y Tecnología": 2
        }),
        Opcion(
            texto: "Gestionar el presupuesto y los plazos.",
            puntuacion: {"Administración y negocios": 3}),
        Opcion(
            texto:
                "Supervisar la seguridad y el bienestar de los trabajadores.",
            puntuacion: {"Ciencias de la salud": 3}),
      ],
    ),
    // Pregunta 26
    Pregunta(
      texto: "Si pudieras dar un curso en una universidad, ¿de qué sería?",
      opciones: [
        Opcion(texto: "Diseño de videojuegos.", puntuacion: {
          "Ingeniería y Tecnología": 3,
          "Arte y Arquitectura": 1
        }),
        Opcion(
            texto: "Antropología cultural.",
            puntuacion: {"Ciencias sociales": 3}),
        Opcion(
            texto: "Botánica aplicada.",
            puntuacion: {"Ciencias agropecuarias": 3}),
      ],
    ),
    // Pregunta 27
    Pregunta(
      texto: "Te sentirías más realizado al:",
      opciones: [
        Opcion(texto: "Publicar un libro.", puntuacion: {"Humanidades": 3}),
        Opcion(
            texto: "Inventar una fórmula matemática.",
            puntuacion: {"Ciencias Exactas": 3, "Ingeniería y Tecnología": 1}),
        Opcion(
            texto: "Organizar una comunidad en torno a un objetivo común.",
            puntuacion: {"Ciencias sociales": 3, "Educación": 2}),
      ],
    ),
    // Pregunta 28
    Pregunta(
      texto: "¿Cuál de las siguientes actividades te resulta más relajante?",
      opciones: [
        Opcion(
            texto: "Escuchar música clásica o ir a una obra de teatro.",
            puntuacion: {"Arte y Arquitectura": 3, "Humanidades": 1}),
        Opcion(
            texto: "Hacer un rompecabezas de lógica.",
            puntuacion: {"Ciencias Exactas": 3, "Ingeniería y Tecnología": 1}),
        Opcion(
            texto: "Cuidar de un enfermo.",
            puntuacion: {"Ciencias de la salud": 3}),
      ],
    ),
    // Pregunta 29
    Pregunta(
      texto: "En una crisis, prefieres ser la persona que:",
      opciones: [
        Opcion(texto: "Analiza los datos para tomar decisiones.", puntuacion: {
          "Administración y negocios": 3,
          "Ciencias Exactas": 2
        }),
        Opcion(
            texto: "Organiza a las personas para que ayuden.",
            puntuacion: {"Ciencias sociales": 3, "Educación": 2}),
        Opcion(
            texto: "Diseña una solución técnica o un plan de contingencia.",
            puntuacion: {"Ingeniería y Tecnología": 3}),
      ],
    ),
    // Pregunta 30
    Pregunta(
      texto: "Si te pidieran crear algo de la nada, ¿qué sería?",
      opciones: [
        Opcion(
            texto: "Un plan para mejorar la calidad de vida en tu ciudad.",
            puntuacion: {
              "Ciencias sociales": 3,
              "Administración y negocios": 2
            }),
        Opcion(
            texto: "Una pieza de maquinaria con una función específica.",
            puntuacion: {"Ingeniería y Tecnología": 3, "Ciencias Exactas": 1}),
        Opcion(
            texto: "Una pieza musical o un ballet.",
            puntuacion: {"Arte y Arquitectura": 3, "Humanidades": 1}),
      ],
    ),
  ];
  @override
  void initState() {
    super.initState();
    _inicializarRespuestasAleatorias();
  }

  void _inicializarRespuestasAleatorias() {
    final random = Random();
    for (int i = 0; i < _preguntas.length; i++) {
      final pregunta = _preguntas[i];
      final opcionAleatoria =
          pregunta.opciones[random.nextInt(pregunta.opciones.length)];
      _procesarRespuesta(i, opcionAleatoria);
    }
  }

  void _procesarRespuesta(int indexPregunta, Opcion nuevaOpcion) {
    setState(() {
      // Eliminar los puntos de la respuesta anterior si existía
      Opcion? opcionAnterior = _respuestasSeleccionadas[indexPregunta];
      if (opcionAnterior != null) {
        opcionAnterior.puntuacion.forEach((area, puntos) {
          _puntuaciones[area] = (_puntuaciones[area] ?? 0) - puntos;
        });
      }

      // Sumar los puntos de la nueva respuesta
      nuevaOpcion.puntuacion.forEach((area, puntos) {
        _puntuaciones[area] = (_puntuaciones[area] ?? 0) + puntos;
      });

      // Guardar la nueva opción seleccionada
      _respuestasSeleccionadas[indexPregunta] = nuevaOpcion;

      // Imprime el estado actual de las puntuaciones en la terminal
      print('Puntuaciones actuales: $_puntuaciones');
      print('Respuestas seleccionadas: $_respuestasSeleccionadas');
    });
  }

  void _enviarRespuestas() {
    bool todasRespondidas = _preguntas.every((pregunta) =>
        _respuestasSeleccionadas.containsKey(_preguntas.indexOf(pregunta)));

    if (!todasRespondidas) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, responde todas las preguntas.")),
      );
      return;
    }

    // Convierte el mapa de puntuaciones a una lista de QuizResult
    final results = [
      QuizResult("Humanidades", _puntuaciones["Humanidades"]!.toDouble()),
      QuizResult("Ingeniería y Tecnología",
          _puntuaciones["Ingeniería y Tecnología"]!.toDouble()),
      QuizResult(
          "Ciencias sociales", _puntuaciones["Ciencias sociales"]!.toDouble()),
      QuizResult("Ciencias de la salud",
          _puntuaciones["Ciencias de la salud"]!.toDouble()),
      QuizResult("Administración y negocios",
          _puntuaciones["Administración y negocios"]!.toDouble()),
      QuizResult("Arte y Arquitectura",
          _puntuaciones["Arte y Arquitectura"]!.toDouble()),
      QuizResult("Educación", _puntuaciones["Educación"]!.toDouble()),
      QuizResult("Ciencias agropecuarias",
          _puntuaciones["Ciencias agropecuarias"]!.toDouble()),
      QuizResult(
          "Ciencias Exactas", _puntuaciones["Ciencias Exactas"]!.toDouble()),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultPage(quizResults: results),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6F5FF),
      appBar: AppBar(
        title: const Text("Cuestionario Vocacional"),
        backgroundColor: const Color(0xffADEBFF),
        foregroundColor: Color(0xff00171F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._preguntas.asMap().entries.map((entry) {
              int index = entry.key;
              Pregunta pregunta = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pregunta.texto,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...pregunta.opciones.map((opcion) {
                    return RadioListTile<Opcion>(
                      title: Text(opcion.texto),
                      value: opcion,
                      groupValue: _respuestasSeleccionadas[index],
                      onChanged: (Opcion? value) {
                        if (value != null) {
                          _procesarRespuesta(index, value);
                        }
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviarRespuestas,
              child: const Text(
                "Enviar",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizResult {
  final String category;
  final double value;

  QuizResult(this.category, this.value);
}

class QuizResultPage extends StatelessWidget {
  final List<QuizResult> quizResults;

  const QuizResultPage({super.key, required this.quizResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 217, 245),
      appBar: AppBar(
        title: const Text('Resultados del Cuestionario'),
        centerTitle: true,
        backgroundColor: const Color(0xFFADEBFF),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tu Perfil de Habilidades',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00171F),
                ),
              ),
              const SizedBox(height: 20),
              _buildRadarChart(),
              const SizedBox(height: 40),
              _buildResultsList(),
              ElevatedButton(
                onPressed: () {
                  // 1. Obtener las áreas con mayor puntuación
                  List<String> topAreas = quizResults
                      .where((result) =>
                          result.value > 0) // Solo áreas con puntuación > 0
                      .map((result) =>
                          result.category) // Extraer el nombre del área
                      .toList();
                  topAreas.sort(
                      (a, b) => b.compareTo(a)); // Ordenar de mayor a menor

                  // Tomar solo las 3 áreas principales (ajusta según sea necesario)
                  topAreas = topAreas.take(3).toList();

                  // 2. Navegar a PlanEstudioPage y pasar las áreas
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanEstudioPage(areas: topAreas),
                    ),
                  );
                },
                child: const Text('Ver Carreras Recomendadas'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadarChart() {
    final List<Color> colors = [const Color.fromARGB(255, 96, 169, 242)];
    final List<RadarDataSet> radarDataSets = [
      RadarDataSet(
        dataEntries: quizResults.map((result) {
          return RadarEntry(value: result.value);
        }).toList(),
        borderColor: colors[0],
        fillColor: colors[0].withOpacity(0.4),
        borderWidth: 2,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: RadarChart(
          RadarChartData(
            radarBackgroundColor:
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.05),
            radarBorderData: const BorderSide(color: Colors.transparent),
            getTitle: (index, angle) {
              return RadarChartTitle(
                text: quizResults[index].category,
              );
            },
            tickCount: 5,
            ticksTextStyle: const TextStyle(color: Colors.black54),
            gridBorderData: const BorderSide(color: Colors.black26),
            titlePositionPercentageOffset: 0.1,
            radarShape: RadarShape.polygon,
            borderData: FlBorderData(show: false),
            dataSets: radarDataSets,
            tickBorderData: BorderSide(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    final double maxScore =
        quizResults.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: quizResults.map((result) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.category,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: result.value / maxScore,
                    backgroundColor: Colors.grey[300],
                    color: const Color.fromARGB(255, 88, 157, 241),
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Puntuación: ${result.value.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// En tu archivo main.dart

// Dentro del botón que desees usar para navegar

