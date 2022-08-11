class LatestApp {
  var image;
  var title;
  var description;
  var link;
  var point;

  LatestApp({required this.image, required this.title, required this.description, required this.link, required this.point});

  Map toMap(LatestApp latestApp) {
    var data = <String, dynamic>{};

    data['image'] = latestApp.image;
    data['title'] = latestApp.title;
    data['description'] = latestApp.description;
    data['link'] = latestApp.link;
    data['point'] = latestApp.point;
    return data;
  }

  LatestApp.fromMap(Map<String, dynamic> mapData) {
    image = mapData['image'];
    title = mapData['title'];
    description = mapData['description'];
    link = mapData['link'];
    point = mapData['point'];
  }
}