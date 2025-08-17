import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'http://10.50.122.148:8000'; // IP de tu computadora física

  // --- INICIAR SESIÓN ---
  static Future<Map<String, dynamic>> iniciarSesion(
      String email, String password) async {
    final url = Uri.parse('$baseUrl/usuario/por-credenciales');
    final body = {"correo": email, "contrasena": password};

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el inicio de sesión: ${response.body}');
    }
  }

  // --- OBTENER CARRERAS POR ÁREA ---
  static Future<List<dynamic>> obtenerCarrerasPorArea(String idArea) async {
    final url = Uri.parse('$baseUrl/carreras?id_area=$idArea');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener carreras');
    }
  }

  // --- GUARDAR FAVORITO ---
  static Future<void> guardarFavorito(
      String idUsuario, String idUni, String idCarrera) async {
    final url = Uri.parse('$baseUrl/uni_carrera_usuario/');
    final body = {
      "id_uni_carrera_usuario": "${idUsuario}${idUni}${idCarrera}",
      "id_Uni_carrera": "UC_${idUni}_${idCarrera}",
      "id_usuario": idUsuario
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al guardar favorito");
    }
  }

  // --- REGISTRAR USUARIO ---
  static Future<Map<String, dynamic>> registrarUsuario(
      String correo, String contrasena) async {
    final url = Uri.parse('$baseUrl/usuario');
    final body = {
      "correo": correo,
      "contrasena": contrasena,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  // --- OBTENER USUARIO (POR CREDENCIALES) ---
  static Future<Map<String, dynamic>> obtenerUsuario(
      String correo, String contrasena) async {
    final url = Uri.parse('$baseUrl/usuario/por-credenciales');
    final body = {
      "correo": correo,
      "contrasena": contrasena,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener usuario: ${response.body}');
    }
  }
}
