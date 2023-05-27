class Cast {

  List<Actor>actores = [];

Cast.fromJsonList(List<dynamic> jsonList){
  if (jsonList == null) return;


  jsonList.forEach((item){
    final actor = Actor.fromJsonMap(item);
    actores.add(actor);
  });
}
}



class Actor{
late  int castId;
late  String character;
late  String creditId;
late  int gender;
late  int id;
late  String name;
late  int order;
late  String profilePath;


  Actor ({
  required  this.castId,
  required  this.character,
  required  this.creditId,
  required  this.gender,
  required  this.id,
  required  this.name,
  required  this.order,
  required  this.profilePath

  });

  Actor.fromJsonMap( Map <String, dynamic> json){

  castId      = json['cast_id'];
  character   = json['character'];
  creditId    = json['credit_id'];
  gender      = json['gender'];
  id          = json['id'];
  name        = json['name'];
  order       = json['order'];
  profilePath = json['profile_path'];


  }

  getFoto(){

    if(profilePath == null){
      return 'https://us.123rf.com/450wm/koblizeek/koblizeek2204/koblizeek220400315/185376169-sin-s%C3%ADmbolo-de-vector-de-imagen-falta-el-icono-disponible-no-hay-galer%C3%ADa-para-este-marcador-de.jpg?ver=6';
    }else{
    return 'https://image.tmdb.org/t/p/w500/$profilePath';

    }
  }
  

}


