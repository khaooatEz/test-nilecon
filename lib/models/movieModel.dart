class MovieModel {
  final String movie;
  final int year;
  final String releaseDate;
  final String director;
  final String character;
  final String movieDuration;
  final String timestamp;
  final String fullLine;
  final String poster;
  final VideoModel video;
  final String audio;

  MovieModel({
    required this.movie,
    required this.year,
    required this.releaseDate,
    required this.director,
    required this.character,
    required this.movieDuration,
    required this.timestamp,
    required this.fullLine,
    required this.poster,
    required this.video,
    required this.audio,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movie: json['movie'],
      year: json['year'],
      releaseDate: json['release_date'],
      director: json['director'],
      character: json['character'],
      movieDuration: json['movie_duration'],
      timestamp: json['timestamp'],
      fullLine: json['full_line'],
      poster: json['poster'],
      video: VideoModel.fromJson(json['video']),
      audio: json['audio'],
    );
  }
}

class VideoModel {
  final String video1080p;
  final String video720p;
  final String video480p;
  final String video360p;

  VideoModel({
    required this.video1080p,
    required this.video720p,
    required this.video480p,
    required this.video360p,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video1080p: json['1080p'],
      video720p: json['720p'],
      video480p: json['480p'],
      video360p: json['360p'],
    );
  }
}
