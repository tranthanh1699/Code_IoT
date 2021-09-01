import 'package:flutter/material.dart';
import 'package:iotmqtt/home.dart';
import 'package:http/http.dart' as http;
import 'package:iotmqtt/updatedatabase.dart';

import 'createaccount.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget
{
 @override
 _LoginPageState createState()=> _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var _userNameErr = "Tài khoản không hợp lệ hoặc dưới 6 kí tự";
  var _passErr = "Mật khẩu không hợp lệ hoặc dưới 6 kí tự";
  var _userInvalid = false;
  var _passInvalid = false;

  String usernamedefault = "toannv10291";
  String passworddefault = "toannv10291";


  clearTextInput(){
    _userController.clear();
    _passController.clear();
  }

   Future<List> _login() async{
     final response = await http.post('http://192.168.1.25:8080//FlutterLogin/login.php', body: {
       "username":_userController.text.trim(),
       "password":_passController.text.trim(),
     });
     print(response.body);

     if(response.body.indexOf("True") >= 0)
       {
         print('Đúng username password trong database');
         setState(() {
           _userInvalid = false;
           _passInvalid = false;
         });

         if(!_userInvalid && !_passInvalid)
         {
           //Navigator.push(context, MaterialPageRoute(builder: gotoHome));
           print('đăng nhập username và password database');

           setState(() {
             clearTextInput();
           });

           Navigator.push(
               context, MaterialPageRoute(builder: (context) => HomePage())
           );
         }
       }
     else if(response.body.indexOf("False") >= 0)
       {
         print('Sai rồi bạn ơi');
         setState(() {
           _userInvalid = true;
           _passInvalid = true;

           clearTextInput();
         });

       }

     /*
     if(_userController.text.length <= 0 )
            {
              _userInvalid = true;
            }
          else
            {
              _userInvalid = false;
            }

          if(_passController.text.length <= 0 )
          {
            _passInvalid = true;
          }
          else
          {
            _passInvalid = false;
          }
      */
   }
  String titleBar = "LOGIN IOT";
  @override
  Widget build(BuildContext context)
  {
      return Scaffold(

        appBar: AppBar(
          title: Row(
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "WELCOME!",
                    style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                  ),
                ),
                Text(
                    "LOGIN APP IOT",
                  style: TextStyle(fontSize: 22, color: Color(0xff606470)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: TextField(
                    controller: _userController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: _userInvalid ? _userNameErr : null,
                      prefixIcon: Container(
                          width: 50, child: Image.asset("ic_user.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,40),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        controller: _passController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                          labelText: "Password",
                          errorText: _passInvalid ? _passErr : null,
                          prefixIcon: Container(
                            width: 50,
                            child: Image.asset("ic_lock.png"),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: onToggleShowPass,
                        child: Text(
                          _showPass ? "HIDE  " :"SHOW  ",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: onSignClicked,
                      child: Text(
                        "LOG IN",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Color(0xff3277D8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    height: 130,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                           GestureDetector(
                              onTap: ShowPageCreateAccount,
                              child: Text(
                                "CREATE ACCOUNT",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: ShowPageUpdatePass,
                              child: Text(
                                "FORGOT PASSWORD?",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),


                        ],
                    ),
                  ),
                ),
              ],
            ) ,
          ),
        ),
      );
  }

  void onSignClicked()
  {
      setState(() {


        if(_userController.text.length < 6 )
        {
          _userInvalid = true;
        }
        else
        {
          _userInvalid = false;
        }

        if(_passController.text.length < 6 )
        {
          _passInvalid = true;
        }
        else
        {
          _passInvalid = false;
        }

        if(_passInvalid && _userInvalid)
          {

          }
        else if(!_userInvalid && !_passInvalid)
          {
            if(_userController.text.trim() == usernamedefault && _passController.text.trim() == passworddefault)
              {
                print('đăng nhập username và password mặc định');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage())
                );
              }
            else
              {
                print('Chay kiểm tra database');
                setState(() {
                  _login();
                });
              }
            /*
            print('Chay kiểm tra database');
            setState(() {
              _login();
            });

             */
          }

          /*
          // kiểm tra nhập đúng theo yêu cầu => kết nối dữ liệu data kiểm tra

          print('CHay kiểm tra database');
          setState(() {
            _login();
          });

           */

          /*
          if(!_userInvalid && !_passInvalid)
          {
              //Navigator.push(context, MaterialPageRoute(builder: gotoHome));

              Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())
              );
          }
          */

      });
  }

  Widget gotoHome(BuildContext context)
  {
    return HomePage();
  }


  void onToggleShowPass()
  {
    setState(() {
      _showPass = !_showPass;
      print(_showPass);
    });
  }

  void ShowPageUpdatePass()
  {
    print('ShowPageUpdatePass');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateDataBasePage())
    );
  }

  Widget gotoHomeUpdate(BuildContext context)
  {
    return UpdateDataBasePage();
  }

  void ShowPageCreateAccount()
  {
    print('ShowPageCreateAccount');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccountPage())
    );
  }

  Widget gotoHomeCreate(BuildContext context)
  {
    return CreateAccountPage();
  }
}