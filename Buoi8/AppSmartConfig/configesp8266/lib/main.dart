import 'package:flutter/material.dart';
import 'package:smartconfig/smartconfig.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_platform_interface/connectivity_platform_interface.dart';
import 'package:flutter/cupertino.dart';


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
  TextEditingController _idwifiController = new TextEditingController();
  TextEditingController _passwifiController = new TextEditingController();
  final _DataAddressMac =  TextEditingController();
  String result = '';
  var _userNameErr = "Tài khoản không hợp lệ hoặc dưới 6 kí tự";
  var _passErr = "Mật khẩu không hợp lệ hoặc dưới 6 kí tự";
  var _userInvalid = false;
  var _passInvalid = false;
  String usernamedefault = "toannv10291";
  String passworddefault = "toannv10291";

  clearTextInput(){
    _idwifiController.clear();
    _passwifiController.clear();
  }

  bool Ena = false;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  void getWifiInfo() async {
    SmartconfigEsp();
  }

  void SmartconfigEsp() async
  {
    var wifiBSSID = await Connectivity().getWifiBSSID();//获取WIFI地址
    await Smartconfig.start(_idwifiController.text.trim(), wifiBSSID , _passwifiController.text.trim()).then((onValue){
      print("MacESP And IP ESP:");
      print("$onValue");
      print("\n");
      if(onValue == null)
      {

        setState(() {
          clearTextInput();
          _DataAddressMac.text = "Error";
        });


      }
      else
      {
        //ShowToask("Đã Config xong!");
        String Data = "";
        Data = onValue.toString();
        int TimA = -1;
        TimA = Data.indexOf(":");
        String MacEsp = "";
        MacEsp = Data.substring(1,TimA);
        print("MacEsp: ");
        print(MacEsp);
        //ShowToask(MacEsp);
        setState(() {
          clearTextInput();
          if(MacEsp == null)
          {
            _DataAddressMac.text = "Error";
          }
          else
          {
            _DataAddressMac.text = MacEsp;
          }


        });
      }

    });
  }

  String titleBar = "SMART CONFIG ESP8266";

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
                "APP SMART CONFIG WIFI ESP",
                style: TextStyle(fontSize: 22, color: Color(0xff606470)),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: TextField(
                  controller: _idwifiController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Tên WiFi",
                    errorText: _userInvalid ? _userNameErr : null,
                    prefixIcon: Container(
                      width: 50, child: Icon(Icons.wifi),
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
                      controller: _passwifiController,

                      style: TextStyle(fontSize: 18, color: Colors.black),
                      obscureText: _showPass,
                      decoration: InputDecoration(
                        labelText: "Mật Khẩu",
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
                      "CONFIG",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _DataAddressMac,
                      readOnly: true,
                      autocorrect: true,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "AddressMac",
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
                  ],
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
    print('chay config wifi');
    getWifiInfo();
  }
  void onToggleShowPass()
  {
    setState(() {
      _showPass = !_showPass;
      print(_showPass);
    });
  }


}
