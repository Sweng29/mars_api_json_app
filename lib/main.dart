import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Camera.dart';
import 'models/mars.dart';
import 'screens/mars_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Future Builder JSON APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _url =
      "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=7ELFJ402WThn3LC9NDpEu2VsN3Dtb4ym11urUTjl";
  List<Mars> marsImagesList = [];

  Future<List<Mars>> _getMarsImages() async {
    var response = await http.get(_url);

    var jsonData = json.decode(response.body);

    try {
      for (var d in jsonData["photos"]) {
        List<Camera> cameraList = [];
        for (var c in d["rover"]["cameras"]) {
          Camera camera =
              new Camera(cameraName: c["name"], fullName: c["full_name"]);
          cameraList.add(camera);
        }

        Mars mars = Mars(
            id: d["id"],
            imageUrl: d["img_src"],
            camera: d["camera"]["name"],
            captureDate: d["earth_date"],
            cameraList: cameraList,
            cameraFullName: d["camera"]["full_name"]);
        marsImagesList.add(mars);
      }
    } catch (e) {
      print("Exception occured : $e");
    }
    if (marsImagesList != null && marsImagesList.length > 0) {
      setState(() {});
    }
    return marsImagesList;
  }

  @override
  void initState() {
    super.initState();
    _getMarsImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: marsImagesList == null && marsImagesList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot == null) {
                    return Center(
                      child: Text('Data not found'),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext buildConext, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index].imageUrl),
                          ),
                          title: Text(snapshot.data[index].camera),
                          subtitle: Text(snapshot.data[index].cameraFullName),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MarsDetails(
                                  mars: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: snapshot.data.length == null
                          ? 0
                          : snapshot.data.length,
                    );
                  }
                },
                future: _getMarsImages(),
              ),
      ),
    );
  }
}
