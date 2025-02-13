import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_hindi/Latest_Page.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:flutter/material.dart';

import 'Shayari_Edit_Page.dart';
import 'allData.dart';

class ShayariListPage extends StatefulWidget {
  String category;
  String categoryName;
  ShayariListPage(this.categoryName,this.category, {super.key});

  @override
  State<ShayariListPage> createState() => _ShayariListPageState();
}
int changeImage=0;
class _ShayariListPageState extends State<ShayariListPage> {
  List tempImage=List.filled(allData.latestList.length, false);
  List imageIndex=List.filled(allData.latestList.length, 0);
  late String shayariSelectName;
  late List selectData;
  List imgCtr=[];
  Uint8List? bytes;
  late int shareIndex;

  @override
  Widget build(BuildContext context) {
    getPath();
    shayariSelectName=widget.category.replaceAll(" ", "_");
    selectData=allData.shayariAllData[widget.categoryName][0][shayariSelectName];
    imgCtr.clear();
    for(int i=0;i<selectData.length;i++){
      imgCtr.add(null);
      imgCtr[i]=WidgetsToImageController();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 66, 87),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          widget.category,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 24, 28, 39),
        child: ListView.builder(
          itemCount: selectData.length,
          itemBuilder: (context, index) {
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
                                  "${selectData[index]}",
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
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.white,width: 2))
                            ),
                            child: IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy('${selectData[index]}').then(( value ) {
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
                                },
                                icon: Icon(
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShayariEditPage(selectData[index]),));
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
    );
  }
}
