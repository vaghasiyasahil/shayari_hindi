import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_hindi/Image_Page.dart';
import 'package:shayari_hindi/Shayari_Edit_Page.dart';
import 'package:shayari_hindi/Shayari_List_Page.dart';
import 'package:shayari_hindi/allData.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'Home_Page.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({super.key});

  @override
  State<LatestPage> createState() => _LatestPageState();
}

var path;
late Directory directory;
Future<void> getPath() async {
  path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  path="$path/Shayari_Hindi";
  directory=Directory(path);
  if(!await directory.exists()){
    directory.create();
  }
}

class _LatestPageState extends State<LatestPage> {
  List tempImage=List.filled(allData.latestList.length, false);
  List imageIndex=List.filled(allData.latestList.length, 0);
  List imgCtr=[];
  Uint8List? bytes;
  late int shareIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status="Latest";
    for(int i=0;i<allData.latestList.length;i++){
      imgCtr.add(null);
      imgCtr[i]=WidgetsToImageController();
    }
  }
  @override
  Widget build(BuildContext context) {
    getPath();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 64, 66, 87),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Shayari",
              style:
              TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.share),
            //   color: Colors.white,
            // )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              color: Color.fromARGB(255,24,28,39),
              child: ListView.builder(itemCount: allData.latestList.length,itemBuilder: (context, index) {
                return Container(
                  height: 300,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: allData.latestColorList[index],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: WidgetsToImage(
                          controller: imgCtr[index],
                          child: Container(
                            color: allData.latestColorList[index],
                            child: InkWell(
                              onTap: () {
                                if(changeImage==30){
                                  changeImage=0;
                                }
                                tempImage[index]=true;
                                changeImage++;
                                imageIndex[index]=changeImage;
                                setState(() { });
                              },
                              child: Container(
                                margin: tempImage[index]?EdgeInsets.all(0):EdgeInsets.all(10),
                                alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children:[
                                      if(tempImage[index])
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                          child: Image.asset(
                                            "${allData.bgImage}img${imageIndex[index]}.jpg",
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      Text(
                                        "${allData.latestList[index]}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            border: Border(top: BorderSide(color: Colors.white)),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Expanded(
                              //   child: Container(
                              //     height: double.infinity,
                              //     decoration: BoxDecoration(
                              //       border: Border(right: BorderSide(color: Colors.white,width: 2))
                              //     ),
                              //     child: IconButton(onPressed: () {
                              //
                              //     }, icon: Icon(
                              //         CupertinoIcons.heart,
                              //       color: Colors.red,
                              //     )),
                              //   ),
                              // ),
                              // Expanded(
                              //   child: Container(
                              //     height: double.infinity,
                              //     decoration: BoxDecoration(
                              //         border: Border(right: BorderSide(color: Colors.white,width: 2))
                              //     ),
                              //     child: IconButton(onPressed: () {
                              //
                              //     }, icon: Icon(
                              //         Icons.download,
                              //       color: Colors.white,
                              //     )),
                              //   ),
                              // ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: Colors.white,width: 2))
                                  ),
                                  child: IconButton(onPressed: () {
                                    FlutterClipboard.copy('${allData.latestList[index]}').then(( value ) {
                                      Fluttertoast.showToast(
                                        msg: "copied..",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        // timeInSecForIosWeb: 1,
                                        backgroundColor: Color.fromARGB(255, 24, 28, 39),
                                        textColor: Colors.white,
                                        fontSize: 25.0,
                                      );
                                    });
                                  }, icon: Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: Colors.white,width: 2))
                                  ),
                                  child: IconButton(onPressed: () {
                                    shareIndex=index;
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero
                                      ),
                                      constraints: BoxConstraints(
                                          maxHeight: 130
                                      ),
                                      context: context,
                                      builder: (context) => ListView.builder(
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            if(index==0){
                                              Share.share('${allData.latestList[shareIndex]}');
                                            }else{
                                              bytes=await imgCtr[shareIndex].capture();
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
                                      },),);
                                  }, icon: Icon(
                                      Icons.share,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  child: IconButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShayariEditPage(allData.latestList[index]),));
                                  }, icon: Icon(
                                      Icons.edit,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromARGB(255, 45, 45, 45),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.home,
                                  color: status=="Home"?Colors.green:Colors.white
                                // size: 35,
                              )
                          ),
                          Expanded(
                            child: Text(
                              "Home",
                              style: TextStyle(
                                // fontSize: 22,
                                  color: status=="Home"?Colors.green:Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LatestPage(),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Icon(
                                Icons.local_fire_department_rounded,
                                color: status=="Latest"?Colors.green:Colors.white
                              // size: 35,
                            )
                          ),
                          Expanded(
                            child: Text(
                              "Latest",
                              style: TextStyle(
                                // fontSize: 22,
                                  color: status=="Latest"?Colors.green:Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePage(),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Icon(
                                Icons.image,
                                color: status=="Image"?Colors.green:Colors.white
                              // size: 35,
                            )
                          ),
                          Expanded(
                            child: Text(
                              "Image",
                              style: TextStyle(
                                // fontSize: 22,
                                  color: status=="Image"?Colors.green:Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
