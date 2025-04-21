import 'package:get/get.dart';
import 'package:movie_test/models/movieModel.dart';
import 'package:movie_test/service/getMovie.dart';

class MovieController extends GetxController {
  var movieList = <MovieModel>[].obs;
  var searchInput = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      isLoading.value = true;
      final movies = await fetchMovie();
      movieList.assignAll(movies);
    } catch (e) {
      print('Error : $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<MovieModel> get filterMovies {
    if (searchInput.value.isEmpty) {
      return movieList;
    } else {
      return movieList
          .where(
            (movie) => movie.movie.toLowerCase().contains(
              searchInput.value.toLowerCase(),
            ),
          )
          .toList();
    }
  }
}
