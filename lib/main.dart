import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Image Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image ;
  final ImagePicker picker = ImagePicker();
  chooseImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  captureImage() async{
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if(image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _image != null ?
                Expanded(
                    child: Image.file(_image!)
                  )
                : const Icon(Icons.image, size: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          chooseImage();
                        },
                        child: const Text('Choose Image')
                    )
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          captureImage();
                        },
                        child: const Text('Capture Image')
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
