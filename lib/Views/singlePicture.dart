import 'package:astronomy_pictures/Models/AstronomyPicture.dart';
import 'package:flutter/material.dart';

class SinglePicture extends StatelessWidget {
  final AstronomyPicture picture;

  const SinglePicture(this.picture, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Picture Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        //using a lisView in case we need to scroll to view the entire text
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Title: ' + picture.title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Date: ' + picture.date!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.network(picture.url!),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Explanation: ' + picture.explanation!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
