import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// 1. Usa 'API_KEY' como el nombre de la variable de entorno.
//    Debes pasar la clave al compilar: --dart-define=API_KEY=TU_CLAVE_REA
// 2. Elimina la variable _model global. Se creará dentro de la función.

Future<String> generarPlanEstudio(List<String> areasDeInteres) async {
  if ("AIzaSyAnF8qCxYAjwvSgRPNP5lkF8ahFyrAN9ig".isEmpty) {
    return 'Error: La API Key no está configurada. Asegúrate de iniciar la app con --dart-define=API_KEY=TU_CLAVE';
  }
  final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: "AIzaSyAnF8qCxYAjwvSgRPNP5lkF8ahFyrAN9ig");

  final areasString = areasDeInteres.join(', ');

  final prompt = '''
    Eres un experto en orientación vocacional.
    Genera una lista de carreras universitarias en México que estén relacionadas con las siguientes áreas de interés: $areasString.
    La respuesta debe ser en formato de lista Markdown.
  ''';

  try {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    if (response.text != null) {
      return response.text!;
    }

    return 'No se pudo generar la lista de carreras.';
  } catch (e) {
    print('Error al generar la lista de carreras: $e');
    return 'Ocurrió un error al generar la lista de carreras. Intenta de nuevo más tarde.';
  }
}

class PlanEstudioPage extends StatefulWidget {
  final List<String> areas;

  const PlanEstudioPage({Key? key, required this.areas}) : super(key: key);

  @override
  State<PlanEstudioPage> createState() => _PlanEstudioPageState();
}

class _PlanEstudioPageState extends State<PlanEstudioPage> {
  late Future<String> _futurePlan;

  @override
  void initState() {
    super.initState();
    _futurePlan = generarPlanEstudio(widget.areas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carreras Recomendadas'),
        backgroundColor: const Color(0xffADEBFF),
      ),
      body: FutureBuilder<String>(
        future: _futurePlan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data!,
              padding: const EdgeInsets.all(16.0),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 16.0),
                h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return const Center(
                child: Text('No hay lista de carreras disponible.'));
          }
        },
      ),
    );
  }
}
