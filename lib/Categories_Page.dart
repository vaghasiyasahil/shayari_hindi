import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayari_hindi/Shayari_List_Page.dart';
import 'package:shayari_hindi/allData.dart';

class CategoriesPage extends StatefulWidget {
  String category;
  String image;
  CategoriesPage(this.category, this.image, {super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShayariListPage(widget.category,"${widget.category} शायरी ${index+1}"),));
            },
            child: Card(
              margin: EdgeInsets.all(7),
              child: Container(
                alignment: Alignment.center,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 65, 67, 88),
                    Color.fromARGB(255, 83, 86, 105),
                    Color.fromARGB(255, 100, 103, 118)
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 7),

                  //Image
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      "${allData.homePageImage}${widget.image}",
                    ),
                  ),

                  //Title
                  title: Text(
                    "${widget.category} शायरी ${index+1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  //Right Side Icon
                  trailing: Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.white,
                  )
                ),
              ),
            ),
          );
        },),
      ),
    );
  }
}
