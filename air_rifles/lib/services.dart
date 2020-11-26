import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

class Services {
  static Future<List<Album>> getPhotos() async {
    try {
      final response =
//      await http.get("https://jsonplaceholder.typicode.com/photos");
      await http.get("https://experty.cc/index.php/wp-json/wp/v2/posts?items=id,link,title,featured_media");
      if (response.statusCode == 200) {
        List<Album> list = parsePhotos(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {

      throw Exception(e.toString());
    }
  }

  // Parse the JSON response and return list of Album Objects //
  static List<Album> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }
}