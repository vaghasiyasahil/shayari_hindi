import 'package:flutter/material.dart';
import 'package:shayari_hindi/One_Image_Page.dart';
import 'package:shayari_hindi/allData.dart';

import 'Home_Page.dart';
import 'Latest_Page.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status="Image";
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
              color: Color.fromARGB(255, 24, 28, 39),
              child: GridView.builder(
                  itemCount: allData.imagePageTotalImage,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OneImagePage("image_page_img_${index+1}.jpg"),));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            "${allData.imagePageImage}image_page_img_${index+1}.jpg",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ImagePage(),));
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
