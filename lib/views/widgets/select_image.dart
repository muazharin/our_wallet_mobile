import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:image_picker/image_picker.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key, this.files}) : super(key: key);
  final void Function(List<File>)? files;
  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<File>? image = [];
  void selectSource() {
    FocusScope.of(context).requestFocus(FocusNode());
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => getImage(ImageSource.gallery),
            child: ListTile(
              leading: const Icon(
                Icons.image,
                color: grayscaleCharcoalLightest,
              ),
              title: Text(
                "Galeri",
                style: contentRegular,
              ),
            ),
          ),
          InkWell(
            onTap: () => getImage(ImageSource.camera),
            child: ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: grayscaleCharcoalLightest,
              ),
              title: Text(
                "Camera",
                style: contentRegular,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }

  void getImage(ImageSource imageSource) async {
    Get.back();
    final XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if (xFile != null) {
      setState(() {
        var fileImage = File(xFile.path);
        image!.add(fileImage);
        widget.files!(image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image!.isNotEmpty && image != null
            ? Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      ButtonText(
                        onTap: () => selectSource(),
                        text: "Tambah file",
                        textColor: primaryWater,
                        icon: const Icon(
                          Icons.add,
                          color: primaryWater,
                          size: 14,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              )
            : const SizedBox(),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: grayscaleStoneLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: image!.isNotEmpty && image != null
                ? Wrap(
                    children: image!.asMap().entries.map<Widget>((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4, bottom: 4),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: SizedBox(
                                  height: 56,
                                  width: 56,
                                  child: Image.file(
                                    e.value,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 64,
                              width: 64,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    print("hit");
                                    setState(() {
                                      image!.removeAt(e.key);
                                      widget.files!(image!);
                                    });
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      color: primaryWater,
                                      height: 16,
                                      width: 16,
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : InkWell(
                    onTap: () => selectSource(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Masukkan gambar disini",
                              style: contentRegular.copyWith(
                                color: grayscaleCharcoalLightest,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Icon(
                              Icons.image_outlined,
                              color: grayscaleCharcoalLightest,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
