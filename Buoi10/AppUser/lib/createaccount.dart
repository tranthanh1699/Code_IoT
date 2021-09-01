import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



void main()
{

  runApp(CreateAccountPage());
}
class CreateAccountPage extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
}


class _MyAppState extends State<CreateAccountPage> {

  String titleBar = "CREATE ACCOUNT";
  var _addressController;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  var _userNameErr = "Tài khoản không hợp lệ và trên 6 kí tự";
  var _passErr = "Mật khẩu không hợp lệ và trên 6 kí tự";
  var _userInvalid = false;
  var _passInvalid = false;

  clearTextInput(){
    _userController.clear();
    _passController.clear();
    _phoneController.clear();
    _emailController.clear();
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

  Future<List> _createaccount() async
  {
    final response = await http.post('http://192.168.1.25:80//FlutterLogin/createaccount.php', body: {
      "username":_userController.text.trim(),
      "password":_passController.text.trim(),
    });

    print(response.body);

    if(response.body.indexOf("A") >= 0)
    {
      // php trả dữ liệu về = A thì đã tồn tại username passwor trong hệ thống
      ShowToask("Username đã tồn tại vui lòng chọn username khác");
      print("Username đã tồn tại vui lòng chọn username khác");
      setState(() {
        clearTextInput();
      });
    }
    else if(response.body.indexOf("B") >= 0)
    {
      //B
      print("Create account thành công");
      ShowToask("Create account thành công");
      setState(() {
        clearTextInput();
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                  child: Text(
                    "WELCOME!", // WELCOME
                    style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                  ),
                ),
                Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(fontSize: 22, color: Color(0xff606470)),
                ),
                //========================================================================
              /*
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: StreamBuilder(
                    builder: (context, snapshot) => TextField(
                      controller: _userController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "UserName",
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
               */


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
                      borderSide: BorderSide(
                        color: Color(0xffCED0D2), width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),

              //========================================================================

                StreamBuilder(
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Container(
                          width: 50, child: Image.asset("ic_phone.png")
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

                //========================================================================
                /*
                StreamBuilder(
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                    obscureText: true,
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

                 */
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,40),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        controller: _passController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Password",
                          errorText: _passInvalid ? _passErr : null,
                          prefixIcon: Container(
                            width: 50,
                            child: Image.asset("ic_lock.png"),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffCED0D2), width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),



                //========================================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: _onSignUpClicked,
                      child: Text(
                        "CREATE ACCOUNT",
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


            print('Chay kiểm tra database');
            setState(() {
              _createaccount();
            });
        }
      });
  }




}






