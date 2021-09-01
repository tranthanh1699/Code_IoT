import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()
{
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
}
class _MyAppState extends State<HomePage> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  PageController _pageController;
  int _page = 0;
  String titleBar         = 'IOT MYSQL';
  String clientIdentifier = 'lamhx';
  String mqtt_server = "mqtt.ngoinhaiot.com";
  String  mqtt_user = "toannv10291";
  String  mqtt_pass = "toannv10291";
  int mqtt_port = 1111; // esp kết nối mqtt => TCP
  String topic = 'toannv10291/maylanh';
  String topicapp = 'toannv10291/quat';

  String data = "Data MQTT";
  String nhietdo = "0";
  String doam = "0";
  String anhsang = "0";
  String biencam = "0";
  var _userNameErr = "Tài khoản không hợp lệ hoặc dưới 6 kí tự";
  var _passErr = "Mật khẩu không hợp lệ hoặc dưới 6 kí tự";
  var _userInvalid = false;
  var _passInvalid = false;

  int trangthairelay1 = 0;

  String tx_den1 = "";
  String tx_den2 = "";
  String tx_text1 = "";
  String tx_text2 = "";

  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;
  StreamSubscription subscription;
  TextEditingController brokerController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController identifierController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  String CheckMQTT = "Disconnect";
  String Connect = "Connect";
  int biencheckMqtt = 0;

  bool isSwitched = false;
  String valueSwich = "OFF";
  bool status = false;
  String textimage = "assets/on.jpg";
  String imagephong1 = "assets/off.jpg";
  String imagephong2 = "assets/off.jpg";
  String imagephong3 = "assets/off.jpg";
  String imagephong4 = "assets/off.jpg";
  String imagephong5 = "assets/off.jpg";
  String imagephong6 = "assets/off.jpg";

  @override
  Widget build(BuildContext context)
  {

    IconData connectionStateIcon;

    switch (client?.connectionState) {
      case mqtt.MqttConnectionState.connected:
        connectionStateIcon = Icons.cloud_done;
        Connect = 'Disconnect';
        break;
      case mqtt.MqttConnectionState.disconnected:
        connectionStateIcon = Icons.cloud_off;
        Connect = 'Connect';
        break;
      case mqtt.MqttConnectionState.connecting:
        connectionStateIcon = Icons.cloud_upload;
        break;
      case mqtt.MqttConnectionState.disconnecting:
        connectionStateIcon = Icons.cloud_download;
        Connect = 'Connect';
        break;
      case mqtt.MqttConnectionState.faulted:
        connectionStateIcon = Icons.error;
        Connect = 'Connect';
        break;
      default:
        connectionStateIcon = Icons.cloud_off;
    }

    void navigationTapped(int page) {
      _pageController.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }

    void onPageChanged(int page) {
      setState(() {
        this._page = page;
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              Icon(connectionStateIcon),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: navigationTapped,
          currentIndex: _page,

          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.local_library),
              title: Text('Cảm Biến'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.add_call),
              title: Text('Điều Khiển'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.message),
              title: Text('Cài Đặt'),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.local_library),
              title: Text('Dự Phòng'),
            ),

          ],
        ),
        body:
        PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            //_buildBrokerPage(connectionStateIcon),
            //_buildSubscriptionsPage(),
            //_buildMessagesPage(),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.lightGreenAccent,
              child: Page1(),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.orange,
              child: Page2(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.tealAccent,
              child: Page3(),
              // child: _buildMessagesPage(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.orange,
              child: Page4(),
              // child: _buildMessagesPage(),
            ),

          ],
        ),

      ),
    );
  }

  Column Page1() {
    return
      Column(
        //child: SingleChildScrollView()
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //SizedBox(height: 10),
          Expanded(
            child:  GridView.count(
              padding: EdgeInsets.all(30),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              crossAxisCount: 2,
              children: <Widget>[
                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Text("NHIỆT ĐỘ",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),
                      // Icon(Icons.adb , size: 70.0,),
                      SizedBox(height: 10),
                      Image(image:AssetImage('assets/8.jpg',),),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("$nhietdo", style: TextStyle(fontSize: 20 , color: Colors.blue),),
                        ],
                      ),
                    ],
                  ),
                ),

                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),

                      Text("ĐỘ ẨM",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),
                      //Icon(Icons.cloud_queue , size: 70.0,),
                      SizedBox(height: 10),
                      Image(
                        image:AssetImage('assets/9.jpg',),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("$doam", style: TextStyle(fontSize: 20, color: Colors.blue),),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text("ÁNH SÁNG",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),

                      //Icon(Icons.language , size: 70.0,),
                      SizedBox(height: 10),
                      Image(
                        image:AssetImage('assets/12.jpg',),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("$anhsang", style: TextStyle(fontSize: 20 , color: Colors.blue),),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text("KHÍ GA",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),
                      //Icon(Icons.android , size: 70.0,),
                      SizedBox(height: 10),
                      Image(
                        image:AssetImage('assets/11.jpg',),
                      ),
                      Text("0",
                        style: TextStyle(
                          fontSize: 20, color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),

                      Text("ĐỘ ẨM ĐẤT",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),
                      //Icon(Icons.android , size: 70.0,),
                      SizedBox(height: 10),
                      Image(
                        image:AssetImage('assets/11.jpg',),
                      ),
                      Text("0",
                        style: TextStyle(
                          fontSize: 20, color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),

                      Text("ĐỘ PH",
                        style: TextStyle(
                          fontSize: 20, color: Colors.red,
                        ),
                      ),
                      //Icon(Icons.android , size: 70.0,),
                      SizedBox(height: 10),
                      Image(
                        image:AssetImage('assets/11.jpg',),
                      ),
                      Text("0",
                        style: TextStyle(
                          fontSize: 20, color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }

  Column Page2() {
    return Column(
      children: <Widget>[
        Expanded(
          child:  GridView.count(
            padding: EdgeInsets.all(30),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            crossAxisCount: 2,

            children: <Widget>[
              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    Text("PHÒNG 1",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Image(
                          image:AssetImage(imagephong1,),
                          height: 50,
                          width: 50,
                        ),

                        //Text("$trangthairelay1" ),
                        RaisedButton(
                          child: Text('ON 1'),
                            //onPressed: onclick,
                          onPressed: () {
                            setState(() {
                              imagephong1 = "assets/off.jpg";
                              status = true;
                              isSwitched = true;
                            });
                            publish("0");
                          },


                        ),

                      ],
                    ),

                  ],
                ),


              ),


              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    Text("PHÒNG 2",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        RaisedButton(
                          child: Text('ON 2'),
                          onPressed: () {
                            setState(()
                            {
                              imagephong1 = "assets/on.jpg";
                              status = false;
                              isSwitched = false;
                            });
                            publish("1");
                          },
                        ),
                        SizedBox(width: 10),

                      ],
                    ),

                  ],
                ),
              ),


              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 3",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        RaisedButton(
                          child: Text('OFF 1'),
                          onPressed: () {
                            publish("OFF1");
                          },
                        ),
                        SizedBox(width: 10),

                      ],
                    ),

                  ],
                ),
              ),

              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 4",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        RaisedButton(
                          child: Text('OFF 1'),
                          onPressed: () {
                            publish("OFF1");
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 5",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        FlutterSwitch(
                          width: 100.0,
                          height: 30.0,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: status,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: false,
                          onToggle: (val){
                            setState(() {
                              status = val;
                              print(status);
                              if(status == true)
                              {
                                print('ON');
                              }
                              else
                              {
                                print('OFF');

                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),


              ),

              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 6",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: Switch(
                            value: isSwitched,
                            onChanged:(value){
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                                if(isSwitched == true)
                                {
                                  print('ON');
                                  valueSwich = "ON";
                                }
                                else
                                {
                                  print('OFF');
                                  valueSwich = "OFF";
                                }
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,

                          ) ,
                        ),

                      ],
                    ),

                  ],
                ),
              ),


              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 6",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: Switch(
                            value: isSwitched,
                            onChanged:(value){
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                                if(isSwitched == true)
                                {
                                  print('ON');
                                  valueSwich = "ON";
                                }
                                else
                                {
                                  print('OFF');
                                  valueSwich = "OFF";
                                }
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,

                          ) ,
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[

                    Text("PHÒNG 6",
                      style: TextStyle(
                        fontSize: 15, color: Colors.red,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image:AssetImage('assets/on.jpg',),
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: Switch(
                            value: isSwitched,
                            onChanged:(value){
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                                if(isSwitched == true)
                                {
                                  print('ON');
                                  valueSwich = "ON";
                                }
                                else
                                {
                                  print('OFF');
                                  valueSwich = "OFF";
                                }
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,

                          ) ,
                        ),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Column Page3() {
    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        FlatButton(
          onPressed: () {
            print('OnClick Image');
          },
          child: Image(
            //image:AssetImage('assets/on.jpg',),
            image:AssetImage('assets/mqtt1.jpg',),
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: TextField(
            controller: _userController,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
              labelText: "Text1",
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
        RaisedButton(
          child: Text('SEND TEXT 1'),
          onPressed: SendText1,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: TextField(
            controller: _passController,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
              labelText: "Text2",
              errorText: _passInvalid ? _passErr : null,
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
        RaisedButton(
          child: Text('SEND TEXT 2'),
          onPressed: (SendText2),
        ),


      ],
    );
  }

  Column Page4() {
    return Column(

      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text('Clear'),
            onPressed: () {
            },
          ),
        )
      ],
    );
  }

  Future getDataPHP() async
  {

    var host = 'http://192.168.1.25:80//DatabasePHP/Getdataflutter.php';
    http.Response response = await http.get(host);
    var Dataphp = response.body;
    //print('$bien.$Dataphp');
    var DataJsonObject = json.decode(Dataphp);
    print('$DataJsonObject');

    print('nhietdo :${DataJsonObject['nhietdo']}');

    print('doam :${DataJsonObject['doam']}');

    print('anhsang :${DataJsonObject['anhsang']}');

    if(DataJsonObject['relay1'] == '0')
    {
      trangthairelay1 = 0;
      print('trangthairelay1 :${trangthairelay1}');
      setState(() {
        imagephong1 = "assets/on.jpg";
      });
    }
    else if(DataJsonObject['relay1'] == '1')
    {
      trangthairelay1 = 1;
      print('trangthairelay1 :${trangthairelay1}');
      imagephong1 = "assets/off.jpg";
    }
    setState(() {
      nhietdo = DataJsonObject['nhietdo'];
      doam = DataJsonObject['doam'];
      anhsang = DataJsonObject['anhsang'];
    });


  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    Timer timer = Timer.periodic(new Duration(seconds: 1), (timer)  {
      getDataPHP();
    });
    super.initState();
  }

  void SendText1()
  {
    print(_userController.text);
    String Datagui = "";
    Datagui = "E" + _userController.text + "F";
    print(Datagui);
    publish(Datagui);

  }
  void SendText2()
  {
    print(_passController.text);
    String Datagui = "";
    Datagui = "G" + _passController.text + "H";
    print(Datagui);
    publish(Datagui);
  }
  void publish(String message) async
  {
    print('message:$message');
    if(trangthairelay1 == 0)
    {
      tx_den1 = message.toString();
    }
    else if(trangthairelay1 == 1)
    {
      tx_den1 = message.toString();
    }
    final response = await http.post('http://192.168.1.25:80//DatabasePHP/Getdatadieukhienflutter.php', body: {
      "den1":tx_den1.trim(),
      "den2":"0",
      "text1":"2222222",
      "text2":"333333",
      //"den2":"_passController.text.trim()",
    });
    print(response.body);
  }
  void onclick()
  {

  }
}
