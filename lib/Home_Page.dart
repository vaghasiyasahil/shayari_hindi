import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari_hindi/Categories_Page.dart';
import 'package:shayari_hindi/Image_Page.dart';
import 'package:shayari_hindi/Latest_Page.dart';
import 'package:shayari_hindi/allData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
String status="Home";
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status="Home";
  }
  @override
  Widget build(BuildContext context) {
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
              //   onPressed: () async {
              //     File app=File("assets/app/shayari_hindi_app.apk");
              //     print("location:${app.path}");
              //     await Share.shareXFiles([XFile("assets/app/shayari_hindi_app.apk")]);
              //   },
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
                color: Color.fromARGB(255, 24, 28, 39),
                child: GridView.builder(
                  itemCount: allData.category.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(allData.category[index],"category_img_${index + 1}.jpg"),));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 66, 87),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.asset(
                                    "${allData.homePageImage}category_img_${index + 1}.jpg",
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${allData.category[index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    )))
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LatestPage(),));
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
        ));
  }
}
