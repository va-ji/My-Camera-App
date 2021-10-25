import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:camera/camera.dart';

class SecPage extends StatelessWidget {
  //final AsyncCallback? takePic;
  //File? picLocation = takePic().then((value) => null)

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture viewer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'View Your Picture Here!!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 500,
            width: 500,
            padding: const EdgeInsets.all(35),
            child: Card(
              elevation: 15,
              margin: const EdgeInsets.all(10),
              child: kIsWeb
                  ? Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(args.path),
                    )
                  : Image(
                      fit: BoxFit.fill,
                      image: FileImage(args),
                    ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Back',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
