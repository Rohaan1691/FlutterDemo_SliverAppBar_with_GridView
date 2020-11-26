import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'services.dart';
import 'album.dart';
import 'gridcell.dart';
import 'SizeHelper.dart';

class GridViewDemo extends StatefulWidget {
  GridViewDemo() : super();

  final String title = "Photos";

  @override
  GridViewDemoState createState() => GridViewDemoState();
}

class GridViewDemoState extends State<GridViewDemo> {
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Icon _searchIcon = Icon(
    Icons.search,
  );

  gridview(AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data.map(
          (album) {
            return GestureDetector(
              child: GridTile(
                child: AlbumCell(album),
              ),
//              onTap: () {
//                goToDetailsPage(context, album);
//              },
            );
          },
        ).toList(),
      ),
    );
  }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            primaryIconTheme: IconThemeData(
                color: Colors.black, size: displayWidth(context) * 0.07)),
        child: Scaffold(
          key: _scaffoldKey,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[createSilverAppBar()];},
            body: Container(
              decoration: BoxDecoration(color: Colors.white30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: FutureBuilder<List<Album>>(
                      future: Services.getPhotos(),
                      builder: (context, snapshot) {
                        // not setstate here
                        //
                        if (snapshot.hasError) {
                          return Text('Error ${snapshot.error}');
                        }
                        //
                        if (snapshot.hasData) {
                          //                  streamController.sink.add(snapshot.data.length);
                          // gridview
                          return gridview(snapshot);
                        }

                        return circularProgress();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: new ListView(
              children: <Widget>[
                Container(
                  child: new UserAccountsDrawerHeader(
                    accountName: Text(
                      "رابطه بنادق هوائية",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    accountEmail: Text(
                      "test@gmail.com",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new ExactAssetImage('assets/background.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('assets/background.jpg')),
                  ),
                  color: Colors.grey,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                new ListTile(
                    leading: Icon(Icons.library_music),
                    title: new Text(
                      "علامة التبويب الأولى",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.movie),
                    title: new Text(
                      "علامة التبويب الثانية",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: new Text(
                      "علامة التبويب الثالثة",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.apps),
                    title: new Text(
                      "علامة التبويب الرابعة",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.dashboard),
                    title: new Text(
                      "علامة التبويب الثالثة",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text(
                      "علامة التبويب الرابعة",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.info),
                    title: new Text(
                      "حول",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: new Text(
                      "تسجيل خروج",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ));
  }

  SliverAppBar createSilverAppBar() {
    return SliverAppBar(
      actions: <Widget>[
        RawMaterialButton(
          elevation: 0.0,
          child: _searchIcon,
          onPressed: () {
            _searchPressed();
          },
          constraints: BoxConstraints.tightFor(
            width: 60,
            height: 60,
          ),
          shape: CircleBorder(),
        ),
      ],
      expandedHeight: displayHeight(context) * 0.3,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.menu, size: displayWidth(context) * 0.07),
        // change this size and style
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 5),
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
                width: displayWidth(context) * 0.5,
                child: CupertinoTextField(
                  controller: _filter,
                  keyboardType: TextInputType.text,
                  placeholder: "بحث...",
                  placeholderStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black54),
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
//            "Air Rifle Association",
                "رابطه بنادق هوائية",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: displayWidth(context) * 0.06,
                    color: Colors.black54,
                    fontFamily: 'PlayfairDisplay'),
              ),

//              background: Image.network("https://miro.medium.com/max/3240/1*9-ujy3CCBhrpkvS7TMLcoQ.png", fit: BoxFit.cover,)
        background: Container(
          height: displayHeight(context) * 0.3,
          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(40.0),
            image: DecorationImage(
//              colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.7), BlendMode.dstATop),
              image: AssetImage('assets/bg4.jpg'), fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        this._searchIcon = Icon(
          Icons.search,
        );
        isSearchClicked = false;
        _filter.clear();
      }
    });
  }
}
