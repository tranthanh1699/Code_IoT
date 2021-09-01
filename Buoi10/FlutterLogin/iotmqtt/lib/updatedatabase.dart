import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main()
{
  runApp(UpdateDataBasePage());
}
class UpdateDataBasePage extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
}


class _MyAppState extends State<UpdateDataBasePage> {

  String titleBar = "UPDATE PASSWORD";
  var _addressController;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passnewController = new TextEditingController();
  String hollow = "";

  clearTextInput(){
    _userController.clear();
    _passController.clear();
    _phoneController.clear();
    _passnewController.clear();
  }

  void ShowToask(String message)
  {
    Fluttertoast.showToast(
        msg: '$message',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<List> _updatepassword() async
  {
    final response = await http.post('http://192.168.1.25:8080//FlutterLogin/updateaccount.php', body: {
      "username":_userController.text.trim(),
      "password":_passController.text.trim(),
      "passwordupdate":_passnewController.text.trim(),
    });

    print(response.body);

    if(response.body.indexOf("E") >= 0)
    {

      //E update password thành công
      ShowToask("Đổi mật khẩu thành công");
      setState(() {
        clearTextInput();
      });
    }
    else if(response.body.indexOf("G") >= 0)
    {
      //G nhập sai password
      ShowToask("UserName hoặc Password nhập sai");
      setState(() {

      });
    }

  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image:AssetImage('assets/17.jpg',),
              ),
              Text(titleBar),

              SizedBox(
                width: 8.0,
              ),

              Image(
                image:AssetImage('assets/12.jpg',),

              ),

            ],
          ),
        ),


        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Image.asset(
                  'assets/mqtt1.jpg',
                  height: 200,
                  width: 300,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "WELCOME!",
                    style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                  ),
                ),
                Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(fontSize: 22, color: Color(0xff606470)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: StreamBuilder(
                    builder: (context, snapshot) => TextField(

                      controller: _userController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Container(
                            width: 50, child: Image.asset("ic_user.png"),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffCED0D2), width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                ),


                StreamBuilder(
                  builder: (context, snapshot) => TextField(

                    controller: _passController,
                    obscureText: false,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password Old",
                      prefixIcon: Container(
                          width: 50, child: Image.asset("ic_lock.png")
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffCED0D2), width: 1,
                        ),
                          borderRadius:  BorderRadius.all(Radius.circular(6)),
                      ),
                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StreamBuilder(
                    builder: (context, snapshot) => TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Container(
                            width: 50, child: Image.asset("ic_mail.png")
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffCED0D2), width: 1,
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                ),


                StreamBuilder(
                  builder: (context, snapshot) => TextField(

                    controller: _passnewController,
                    obscureText: false,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Container(
                          width: 50, child: Image.asset("ic_lock.png"),
                      ),

                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffCED0D2), width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: _onSignUpClicked,
                      child: Text(
                        "UPDATE",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),

                      color: Color(0xff3277D8),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

  void _onSignUpClicked()
  {
      if(_passnewController.text.length < 6)
        {
          // không hợp lệ
          ShowToask("Error! Mật khẩu mới trên 6 kí tự");
        }
      else
        {
          print('Chạy Database');
          setState(() {
            _updatepassword();
          });
        }
  }
}






