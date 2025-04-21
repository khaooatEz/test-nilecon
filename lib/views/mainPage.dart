import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_test/controllers/movieController.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MovieController movieController = Get.put(MovieController());
  final TextEditingController searchController = TextEditingController();

  String durationToMinutes(String duration) {
    final parts = duration.split(':');
    if (parts.length != 3) return '0';

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    final totalMinutes = (hours * 60) + minutes;
    return '$totalMinutes Minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 29, 43, 1),

      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (movieController.isLoading.value) {
                return Text('data');
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return Container(
                          margin: EdgeInsets.only(
                            left: 24,
                            right:
                                movieController.searchInput.value.isNotEmpty
                                    ? 4
                                    : 24,
                          ),
                          child: TextFormField(
                            controller: searchController,
                            onChanged:
                                (value) => {
                                  movieController.searchInput.value = value,
                                },
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search_outlined),
                              prefixIconColor: Color.fromRGBO(146, 146, 157, 1),
                              filled: true,
                              fillColor: Color.fromRGBO(37, 40, 54, 1),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Obx(() {
                      return movieController.searchInput.value.isNotEmpty
                          ? Container(
                            margin: EdgeInsets.only(right: 10),
                            child: TextButton(
                              onPressed: () {
                                searchController.clear();
                                movieController.searchInput.value = '';
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          : SizedBox.shrink();
                    }),
                  ],
                );
              }
            }),

            Obx(() {
              if (movieController.isLoading.value) {
                return Expanded(
                  child: Center(child: Image.asset('asset/icon.png')),
                );
              }
              if (movieController.filterMovies.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'The movie you are looking for was not found',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: ListView.builder(
                    itemCount: movieController.filterMovies.length,
                    itemBuilder: (context, index) {
                      final movie = movieController.filterMovies[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  backgroundColor: Color.fromRGBO(
                                    37,
                                    40,
                                    54,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  contentPadding: EdgeInsets.all(16),
                                  content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              movie.poster,
                                              height: 180,
                                              width: double.infinity,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            movie.movie,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Year: ${movie.year}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Duration: ${durationToMinutes(movie.movieDuration)}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Release Date: ${movie.releaseDate}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Director: ${movie.director}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Character: ${movie.character}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: Text(
                                        'Close',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        },

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  movie.poster,
                                  height: 147,
                                  width: 112,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          color: Color.fromRGBO(
                                            18,
                                            205,
                                            217,
                                            1,
                                          ),
                                        ),
                                        child: Text(
                                          'Free',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        movie.movie,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: Color.fromRGBO(
                                              146,
                                              146,
                                              157,
                                              1,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            movie.year.toString(),
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                146,
                                                146,
                                                157,
                                                1,
                                              ),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.watch_later_rounded,
                                            color: Color.fromRGBO(
                                              146,
                                              146,
                                              157,
                                              1,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            durationToMinutes(
                                              movie.movieDuration,
                                            ),
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                146,
                                                146,
                                                157,
                                                1,
                                              ),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
