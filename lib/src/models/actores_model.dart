class Cast {

  List<Actor> actores = new List();

  Cast.formJsonList( List<dynamic> jsonList ) {

    if (jsonList == null ) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJdonMap(item);
      actores.add(actor);
    });

  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });
  
  Actor.fromJdonMap( Map<String, dynamic> json) {
    castId      = json['cast_id'];
    character   = json['character'];
    gender      = json['gender'];
    creditId    = json['credit_id'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {

    if (profilePath == null) {
      return 'https://forum.mikrotik.com/styles/canvas/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
