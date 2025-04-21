import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_test/models/movieModel.dart';

Future<List<MovieModel>> fetchMovie() async {
  final url = Uri.parse('https://whoa.onrender.com/whoas/random?results=20');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  } else {
    throw Exception('error respone');
  }
}
