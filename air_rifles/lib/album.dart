class Album {
//  int albumId;
//  int id;
  String title;
//  String url;
  String thumbnailUrl ;
//  String thumbnailUrl = "https://experty.cc//wp-content//uploads//2020//11//unnamed-file-2-150x150.jpg";

  Album({this.title, this.thumbnailUrl});

  // Return object from JSON //
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        title: json['title']['rendered'] as String,
        thumbnailUrl: json['featured_image_src'] as String
    );
  }
}