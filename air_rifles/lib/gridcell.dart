import 'package:flutter/material.dart';
import 'album.dart';


class AlbumCell extends StatelessWidget {
  const AlbumCell( this.album);
  @required
  final Album album;
//  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
//      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(width: 1, color: Colors.grey)
      ),
      margin: EdgeInsets.all(5),
      child: Padding(
        padding:
        EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
        child: Container(
//          decoration: BoxDecoration(
//            color: Colors.black
//          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:
                 ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),

                  child: Image.network(album.thumbnailUrl,
//                    width: 200,
                    height: 150,
//                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child:
                Text(
                  album.title,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}