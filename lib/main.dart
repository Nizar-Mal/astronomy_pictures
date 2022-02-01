import 'package:astronomy_pictures/View%20Models/PicturesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Views/ListOfPictures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<PictureViewModel>(create:(_)=>PictureViewModel(),
          child: const ListOfPictures(),),
    );
  }
}

