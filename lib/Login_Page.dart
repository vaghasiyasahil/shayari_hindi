import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari_hindi/Home_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  String userNameError="";
  String passwordError="";
  @override
  Widget build(BuildContext context) {
    getPermission();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Enter your credential for login",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
              ),
              SizedBox(height: 70,),
              Container(
                padding: EdgeInsets.only(left: 40,right: 40),
                child: TextField(
                  controller: userName,
                  onChanged: (value) {
                    userNameError="";
                    setState(() { });
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    errorText: userNameError!=""?userNameError:null,
                    hintStyle: TextStyle(
                      fontSize:
                        20
                    ),
                    prefixIcon: Icon(
                        Icons.account_circle_outlined,
                      size: 35,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 24, 28, 39)
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15)
                      )
                    ),
          
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 40,right: 40),
                child: TextField(
                  controller: password,
                  onChanged: (value) {
                    passwordError="";
                    setState(() { });
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: passwordError!=""?passwordError:null,
                    hintStyle: TextStyle(
                        fontSize:
                        20
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 35,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 24, 28, 39)
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        )
                    ),
          
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  String getUserName=userName.text;
                  String getPassword=password.text;
                  if(getUserName=="user"){
                    if(getPassword=="1234"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                    }else{
                      passwordError="Password is wrong !!";
                      setState(() { });
                    }
                  }else{
                    userNameError="Username is wrong !!";
                    setState(() { });
                  }
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 40,right: 40),
                  margin: EdgeInsets.only(left: 40,right: 40),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 24, 28, 39),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    )
                  ),
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getPermission() async {
    if (!await Permission.contacts.request ().isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.photos,
      ].request();
    }
  }
}
