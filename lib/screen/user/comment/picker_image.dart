import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerImage extends StatefulWidget {
  final Function(List<String>) onImagesSelected;

  const PickerImage({super.key, required this.onImagesSelected});

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> {
  List<File> selectedImages = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              getImages();
            },
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green[400], // foreground text
                side: BorderSide(color: Color.fromARGB(255, 112, 154, 49)),
                fixedSize: Size(250, 50)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Thêm hình ảnh ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.camera_alt_outlined)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
          ),
          Container(
            width: 300.0,
            //height: 100,
            child: selectedImages.isEmpty
                ? const Center()
                : Container(
                    height: 100,
                    child: GridView.builder(
                      //padding: EdgeInsets.only(top: 100),
                      itemCount: selectedImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: kIsWeb
                              ? Image.network(
                                  selectedImages[index].path,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                )
                              : Image.file(
                                  selectedImages[index],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  //////////////////////
  Future<void> getImages() async {
    final pickedFile = await picker.pickMultiImage(
      requestFullMetadata: true,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFile.isNotEmpty) {
      List<File> images = pickedFile.map((xfile) => File(xfile.path)).toList();

      setState(() {
        selectedImages.addAll(images);
      });

      // Call the callback with the selected images' paths
      widget.onImagesSelected(selectedImages.map((file) => file.path).toList());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected')),
      );
    }
  }
}
