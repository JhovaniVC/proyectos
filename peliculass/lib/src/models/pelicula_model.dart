class Peliculas {

  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add( pelicula );
    }

  }

}



class Pelicula {


 late String uniqueId;

 late int voteCount;
 late int id;
 late bool video;
 late double voteAverage;
 late String title;
 late double popularity;
 late String posterPath;
 late String originalLanguage;
 late String originalTitle;
 late List<int> genreIds;
 late String backdropPath;
 late bool adult;
 late String overview;
 late String releaseDate;

  Pelicula({

    required this.uniqueId,

    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> json ) {

    
    uniqueId = json['unique_Id'];
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];


  }
  getPosterImg(){

    if(posterPath ==null){
      return 'https://us.123rf.com/450wm/koblizeek/koblizeek2204/koblizeek220400315/185376169-sin-s%C3%ADmbolo-de-vector-de-imagen-falta-el-icono-disponible-no-hay-galer%C3%ADa-para-este-marcador-de.jpg?ver=6';
    }else{
    return 'https://image.tmdb.org/t/p/w500/$posterPath';

    }
  }




getBackgroundImg(){

    if(posterPath ==null){
      return 'https://us.123rf.com/450wm/koblizeek/koblizeek2204/koblizeek220400315/185376169-sin-s%C3%ADmbolo-de-vector-de-imagen-falta-el-icono-disponible-no-hay-galer%C3%ADa-para-este-marcador-de.jpg?ver=6';
    }else{
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';

    }
  }

}


