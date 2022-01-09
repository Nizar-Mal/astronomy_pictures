import 'package:astronomy_pictures/Models/AstronomyPicture.dart';
import 'package:astronomy_pictures/View%20Models/PicturesViewModel.dart';
import 'package:astronomy_pictures/Views/singlePicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfPictures extends StatefulWidget {
  const ListOfPictures({Key? key}) : super(key: key);

  @override
  _ListOfPicturesState createState() => _ListOfPicturesState();
}

class _ListOfPicturesState extends State<ListOfPictures> {
  final _picturesViewModel = PictureViewModel();
  final searchController = TextEditingController();

  TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  @override
  initState() {
    _picturesViewModel.checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('images'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _picturesViewModel.checkConnection();
              setState(() {
                /*This call will reload the page and the API will be called again*/
              });
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: _picturesViewModel.connectionStatus == ConnectionStatus.connected
            ? FutureBuilder<List<AstronomyPicture>>(
                future: _picturesViewModel.fetchPictures(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) =>
                            pictureCard(snapshot.data![index]),
                      );
                    } else {
                      return somethingWentWrong();
                    }
                  }

                  return somethingWentWrong();
                },
              )
            : _picturesViewModel.connectionStatus ==
                    ConnectionStatus.notConnected
                ? somethingWentWrong()
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
      ),
    );
  }

  Widget pictureCard(AstronomyPicture picture) {
    if (picture.url == null) {
      return const SizedBox.shrink();
    }
    if (picture.url!.contains('youtube')) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => SinglePicture(picture)));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Center(
            child: Stack(
              children: [
                Image.network(
                  picture.url!,
                  fit: BoxFit.none,
                ),
                Positioned(
                  top: 1,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      child: Text(
                        picture.title!,
                        style: textStyle,
                      ),
                      color: Colors.black,
                      padding: const EdgeInsets.all(1.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      child: Text(
                        picture.date!,
                        style: textStyle,
                      ),
                      color: Colors.black,
                      padding: const EdgeInsets.all(1.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget somethingWentWrong() {
    return const Center(
      child: Text(
          'Something is not right :(\nPlease check your internet connection'),
    );
  }
}
