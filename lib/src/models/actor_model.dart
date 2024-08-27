class Cast {

  List<Actor> actors = List.empty(growable: true);

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList) {

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    }

  }

}

class Actor {
  late int castId;
  late String character;
  late String creditId;
  late int gender;
  late int id;
  late String name;
  late int order;
  late String? profilePath;

  Actor({
    required this.castId,
    required this.character,
    required this.creditId,
    required this.gender,
    required this.id,
    required this.name,
    required this.order,
    required this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getPicture() {
    if (profilePath == null) {
      return 'no_avatar.gif';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}