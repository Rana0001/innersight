import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  AddImage({Key? key, this.img, this.images}) : super(key: key);
  File? img;
  List<File>? images;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  List<File> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.img != null) {
      images.add(widget.img!);
      widget.images!.add(widget.img!);
    }
  }

  File? img;

  void _bottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: ctx,
      builder: (_) {
        return bottomSheet(_);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      /// Create a GridView
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: GridView.builder(
          itemCount: images.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext ctx, index) {
            if (index == images.length) {
              return InkWell(
                onTap: () {
                  _bottomSheet(context);
                },
                child: Container(
                    width: 100,
                    height: 125,
                    decoration: BoxDecoration(
                        color: theme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: theme.primary, size: 40),
                        const SizedBox(height: 10),
                        Text(
                          'Add more images',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
              );
            }
            return Stack(
              children: [
                Container(
                    width: 120,
                    height: 125,
                    decoration: BoxDecoration(
                        color: theme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(images[index]))),
                Positioned(
                  top: -10,
                  right: 0,
                  child: Container(
                    height: 25,
                    width: 25,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          images.removeAt(index);
                          widget.images!.removeAt(index);
                        });
                      },
                      padding: const EdgeInsets.only(left: 0),
                      icon: const Icon(
                        Icons.close,
                        size: 13,
                        color: Color(0xff677294),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, VoidCallback tapHandler,
      BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: const Color(0xff677294),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff677294),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: tapHandler,
    );
  }

  _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          images.add(img!);
          widget.images!.add(img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
        height: 350,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xffC4C4C4),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Add More Images',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          buildListTile(Icons.camera_alt_rounded, 'Take a photo', () {
            _browseImage(ImageSource.camera);
          }, context),
          buildListTile(Icons.photo, 'Upload from gallery', () {
            _browseImage(ImageSource.gallery);
          }, context),
          const SizedBox(height: 10),
        ]));
  }
}
