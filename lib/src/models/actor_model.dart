class Actors {
  List<Actor> list = new List();
  Actors();
  Actors.fromJsonList(List<dynamic> jsonList) {
    jsonList.forEach((actor) => list.add(Actor.fromJson(actor)));
  }
}

class Actor {
  String _img =  'https://altapeli.com/wp-content/uploads/2019/03/orionthemes-placeholder-image-1.png';
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

  Actor.fromJson(Map<String, dynamic> json) {
    this.castId = json['cast_id'];
    this.character = json['character'];
    this.creditId = json['credit_id'];
    this.gender = json['gender'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.profilePath = json['profile_path'] ?? _img;
  }

  String getImageURL() {   
    String urlImage = 'https://image.tmdb.org/t/p/w500/$profilePath';
    return urlImage;
  }
}
