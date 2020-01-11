import 'package:flutter/material.dart';
import 'package:untitled/models/mars.dart';

class MarsDetails extends StatelessWidget {
  final Mars mars;

  MarsDetails({this.mars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mars.camera),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(mars.imageUrl),
                ),
              ),
              Text(
                'ID : ${mars.id}',
              ),
              Text('Full name : ${mars.cameraFullName}'),
              Text('Camera : ${mars.camera}'),
              Text('Capture date : ${mars.captureDate}'),
            ],
          ),
        ),
      ),
    );
  }
}
