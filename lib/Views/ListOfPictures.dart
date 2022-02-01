import 'package:astronomy_pictures/Models/AstronomyPicture.dart';
import 'package:astronomy_pictures/View%20Models/PicturesViewModel.dart';
import 'package:astronomy_pictures/Views/singlePicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfPictures extends StatefulWidget {
  const ListOfPictures({Key? key}) : super(key: key);

  @override
  _ListOfPicturesState createState() => _ListOfPicturesState();
}

class _ListOfPicturesState extends State<ListOfPictures> {

  ScrollController? _controller;

  TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  @override
  initState() {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange) {
      debugPrint('reached the bottom!!');
      Provider.of<PictureViewModel>(context,listen: false).fetchPictures(loadingExtra: true);
    }
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListView(
            // shrinkWrap: true,
          //  physics: const NeverScrollableScrollPhysics(),
            children: [

             Container(height:30, color: Colors.green,child: const TextField()),
              Consumer<PictureViewModel>(
                builder: (context, model, _) {
                  if (model.pictures.isEmpty) {
                    return  Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey.shade700,
                      ),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.all(5),
                    child: ListView.builder(
                      controller: _controller,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: model.pictures.length +1,
                        itemBuilder: (context, index) =>
                            index >= model.pictures.length
                                ? _loadingWidget()
                                : pictureCard(model.pictures[index])),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Consumer<PictureViewModel>(
      builder: (context, model, _) {
        if (model.isLoadingExtra) {
          return const Padding(
            padding:  EdgeInsets.only(top:10.0,bottom: 30.0),
            child:  Center(child: Text('Loading...')),
          );
        }

        return const SizedBox.shrink();
      },
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
                ),
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
