import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_hindi/allData.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'Latest_Page.dart';

class ShayariEditPage extends StatefulWidget {
  String shayari;
  ShayariEditPage(this.shayari, {super.key});

  @override
  State<ShayariEditPage> createState() => _ShayariEditPageState();
}

class _ShayariEditPageState extends State<ShayariEditPage> {
  Color bgColor = Colors.white;
  Color textColor = Colors.black;
  double textSize = 30;
  String textStyle = "";
  String bgImageName = "";
  String fontFa="Normal";
  late TextEditingController editTextCtr;
  @override
  WidgetsToImageController imageController = WidgetsToImageController();
  Uint8List? bytes;
  Widget build(BuildContext context) {
    editTextCtr=TextEditingController(text: widget.shayari);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 66, 87),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edit",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetsToImage(
              controller: imageController,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(7),
                height: 500,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (bgImageName != "")
                        Image.asset(
                          "$bgImageName",
                          // width: double.infinity,
                          height: 500,
                          fit: BoxFit.fill,
                        ),
                      Text(
                        "${widget.shayari}",
                        style: TextStyle(
                            fontWeight: textStyle == "Bold"
                                ? FontWeight.bold
                                : textStyle == "Bold Italic"
                                    ? FontWeight.bold
                                    : null,
                            fontStyle: textStyle == "Italic"
                                ? FontStyle.italic
                                : textStyle == "Bold Italic"
                                    ? FontStyle.italic
                                    : null,
                            fontFamily: fontFa!="Normal"?fontFa:null,
                            fontSize: textSize,
                            color: textColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Row(
                children: [
                  Text(
                    "Text Size: ${textSize.toInt()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.blue,
                      min: 10,
                      max: 100,
                      value: textSize,
                      onChanged: (value) {
                        textSize = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children:[
                        Text(
                        "Font Family: ",
                        style:
                            TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        Text(
                          "$fontFa",
                          style:
                          TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFa!="Normal"?fontFa:null
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(constraints: BoxConstraints(maxHeight: 200),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),context: context, builder: (context) {
                        return ListView.builder(itemCount: allData.fontList.length,itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                fontFa=allData.fontList[index];
                              });
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 64, 66, 87),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Text(
                                "${allData.fontList[index]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  fontFamily: "${allData.fontList[index]}"
                                ),
                              ),
                            ),
                          );
                        },);
                      },);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 15, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      alignment: Alignment.center,
                      child: Text(
                        "Change",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 64, 66, 87),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      "Bg Color",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 500,
                                  child: ColorPicker(
                                    pickerColor: Colors.black,
                                    onColorChanged: (value) {
                                      bgColor = value;
                                      bgImageName = "";
                                      setState(() {});
                                    },
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context); 
                                      },
                                      child: Text("Got it"))
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          color:
                              bgColor == Colors.white ? Colors.grey : bgColor,
                          height: 50,
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 64, 66, 87),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      "Text Color",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 500,
                                  child: ColorPicker(
                                    pickerColor: Colors.black,
                                    onColorChanged: (value) {
                                      textColor = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Got it"))
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          color: textColor == Colors.white
                              ? Colors.grey
                              : textColor,
                          height: 50,
                        ),
                      )),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(7),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          constraints: BoxConstraints(maxHeight: 200),
                          context: context,
                          builder: (context) {
                            return ListView.builder(
                              itemCount: allData.styleList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (index == 0) {
                                      textStyle = "Bold";
                                    } else if (index == 1) {
                                      textStyle = "Italic";
                                    } else {
                                      textStyle = "Bold Italic";
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 24, 28, 39),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${allData.styleList[index]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight:
                                              allData.styleList[index] == "Bold"
                                                  ? FontWeight.bold
                                                  : allData.styleList[index] ==
                                                          "Bold Italic"
                                                      ? FontWeight.bold
                                                      : null,
                                          fontStyle: allData.styleList[index] ==
                                                  "Italic"
                                              ? FontStyle.italic
                                              : allData.styleList[index] ==
                                                      "Bold Italic"
                                                  ? FontStyle.italic
                                                  : null),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, right: 5, left: 5, bottom: 0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[0],
                            Text(
                              "${allData.buttonNameList[0]}",
                              style: TextStyle(
                                // fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Container(
                                height: 150,
                                width: double.maxFinite,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allData.imageBgTotalImage,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        bgImageName =
                                            "${allData.bgImage}img${index + 1}.jpg";
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        child: Image.asset(
                                          "${allData.bgImage}img${index + 1}.jpg",
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, right: 5, left: 5, bottom: 0),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[1],
                            Text(
                              "${allData.buttonNameList[1]}",
                              style: TextStyle(
                                  // fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              title: Text(
                                "Add your own or edit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: TextField(
                                controller: editTextCtr,
                                textAlign: TextAlign.center,
                                maxLines: null,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 5),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(255, 238, 238, 238)
                                              ),
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          widget.shayari=editTextCtr.text;
                                          Navigator.pop(context);
                                          setState(() { });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 5),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 64, 66, 87),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, right: 5, left: 5, bottom: 0),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[2],
                            Text(
                              "${allData.buttonNameList[2]}",
                              style: TextStyle(
                                  // fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                )),
            Container(
                margin: EdgeInsets.all(7),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () async {
                            bytes=await imageController.capture();
                            path="${directory.path}/Shayari_Hindi_Image_${Random().nextInt(10000000)}.png";
                            File imageSave=File(path);
                            imageSave.writeAsBytes(bytes!);
                            print("Image Saved Succfully");
                            Fluttertoast.showToast(
                              msg: "Saved..",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              // timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 24, 28, 39),
                              textColor: Colors.white,
                              fontSize: 25.0,
                            );
                          },
                          child: Container(
                                                margin:
                            EdgeInsets.only(top: 0, right: 5, left: 5, bottom: 5),
                                                decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                height: 50,
                                                child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[3],
                            Text(
                              "${allData.buttonNameList[3]}",
                              style: TextStyle(
                                  // fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                                                ),
                                              ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            Share.share('${widget.shayari}');
                          },
                          child: Container(
                                                margin:
                            EdgeInsets.only(top: 0, right: 5, left: 5, bottom: 5),
                                                height: 50,
                                                decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[4],
                            Text(
                              "${allData.buttonNameList[4]}",
                              style: TextStyle(
                                  // fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                                                ),
                                              ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                              constraints: BoxConstraints(maxHeight: 100),
                              context: context, builder: (context) {
                              return ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    if(index==0){
                                      Share.share('${allData.latestList[index]}');
                                    }else{
                                      bytes=await imageController.capture();
                                      path="${directory.path}/Shayari_Hindi_Image_${Random().nextInt(10000000)}.png";
                                      File image=File(path);
                                      image.writeAsBytes(bytes!);
                                      await Share.shareXFiles([XFile(path)]);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 64, 66, 87),
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                    child: Text(
                                      "${index==0?"Share Text":"Share Image"}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                );
                              },);
                            },);
                          },
                          child: Container(
                                                margin:
                            EdgeInsets.only(top: 0, right: 5, left: 5, bottom: 5),
                                                height: 50,
                                                decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allData.buttonIconList[5],
                            Text(
                              "${allData.buttonNameList[5]}",
                              style: TextStyle(
                                  // fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                                                ),
                                              ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
