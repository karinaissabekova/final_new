import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class ApiCubit extends Cubit<List<Map<String, String>>> {
  ApiCubit() : super([]);

  final dio = Dio();

  Future<void> fetchNews() async {
    try {
      final res = await dio.get("https://dummyjson.com/posts");

      final list = res.data["posts"] as List;

      final news = list.map((e) {
        return {
          "title": e["title"].toString(),
          "body": e["body"].toString(),
          "link": "https://dummyjson.com", // ссылка
        };
      }).toList();

      emit(news);
    } catch (e) {
      print("ERROR: $e");
      emit([
        {
          "title": "Ошибка загрузки 😢",
          "body": "",
          "link": "",
        }
      ]);
    }
  }
}