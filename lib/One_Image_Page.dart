import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_hindi/allData.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'Latest_Page.dart';

class OneImagePage extends StatefulWidget {
  String imageName;
  OneImagePage(this.imageName, {super.key});

  @override
  State<OneImagePage> createState() => _OneImagePageState();
}

class _OneImagePageState extends State<OneImagePage> {
  WidgetsToImageController imageCtr = WidgetsToImageController();
  Uint8List? bytes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPath();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            color: Color.fromARGB(255, 24, 28, 39),
            child: Column(
              children: [
                Expanded(
                  flex: 11,
                  child: Container(
                    alignment: Alignment.center,
                    child: WidgetsToImage(
                      controller: imageCtr,
                      child: Image.asset(
                        "${allData.imagePageImage}${widget.imageName}",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () async {
                          bytes=await imageCtr.capture();
                          path="${directory.path}/Shayari_Hindi_Image_${Random().nextInt(10000000)}.png";
                          File image=File(path);
                          image.writeAsBytes(bytes!);
                          await Share.shareXFiles([XFile(path)]);
                        }, icon: Icon(
                          Icons.share,
                        color: Colors.white,
                      )
                      ),
                    )
                ),
              ],
            ),
          ),
      ),
    );
  }
}
