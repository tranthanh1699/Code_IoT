import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void ShowToask(String message)
{
  Fluttertoast.showToast(
      msg: '$message',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void main()
{
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, '1'),
      Company(2, '2'),
      Company(3, '3'),
      Company(4, '4'),
      Company(5, '5'),
    ];
  }
}

class GioDuoi {
  int id;
  String name;

  GioDuoi(this.id, this.name);

  static List<GioDuoi> getCompanies() {
    return <GioDuoi>[
      GioDuoi(0, '0'),
      GioDuoi(1, '1'),
      GioDuoi(2, '2'),
      GioDuoi(3, '3'),
      GioDuoi(4, '4'),
      GioDuoi(5, '5'),
      GioDuoi(6, '6'),
      GioDuoi(7, '7'),
      GioDuoi(8, '8'),
      GioDuoi(9, '9'),
      GioDuoi(10, '10'),
      GioDuoi(11, '11'),
      GioDuoi(12, '12'),
      GioDuoi(13, '13'),
      GioDuoi(14, '14'),
      GioDuoi(15, '15'),
      GioDuoi(16, '16'),
      GioDuoi(17, '17'),
      GioDuoi(18, '18'),
      GioDuoi(19, '19'),
      GioDuoi(20, '20'),
      GioDuoi(21, '21'),
      GioDuoi(22, '22'),
      GioDuoi(23, '23'),
    ];
  }
}

class PhutDuoi {
  int id;
  String name;

  PhutDuoi(this.id, this.name);

  static List<PhutDuoi> getCompanies() {
    return <PhutDuoi>[
      PhutDuoi(0, '0'),
      PhutDuoi(1, '1'),
      PhutDuoi(2, '2'),
      PhutDuoi(3, '3'),
      PhutDuoi(4, '4'),
      PhutDuoi(5, '5'),
      PhutDuoi(6, '6'),
      PhutDuoi(7, '7'),
      PhutDuoi(8, '8'),
      PhutDuoi(9, '9'),
      PhutDuoi(10, '10'),
      PhutDuoi(11, '11'),
      PhutDuoi(12, '12'),
      PhutDuoi(13, '13'),
      PhutDuoi(14, '14'),
      PhutDuoi(15, '15'),
      PhutDuoi(16, '16'),
      PhutDuoi(17, '17'),
      PhutDuoi(18, '18'),
      PhutDuoi(19, '19'),
      PhutDuoi(20, '20'),
      PhutDuoi(21, '21'),
      PhutDuoi(22, '22'),
      PhutDuoi(23, '23'),
      PhutDuoi(24, '24'),
      PhutDuoi(25, '25'),
      PhutDuoi(26, '26'),
      PhutDuoi(27, '27'),
      PhutDuoi(28, '28'),
      PhutDuoi(29, '29'),
      PhutDuoi(30, '30'),
      PhutDuoi(31, '31'),
      PhutDuoi(32, '32'),
      PhutDuoi(33, '33'),
      PhutDuoi(34, '34'),
      PhutDuoi(35, '35'),
      PhutDuoi(36, '36'),
      PhutDuoi(37, '37'),
      PhutDuoi(38, '38'),
      PhutDuoi(39, '39'),
      PhutDuoi(40, '40'),
      PhutDuoi(41, '41'),
      PhutDuoi(42, '42'),
      PhutDuoi(43, '43'),
      PhutDuoi(44, '44'),
      PhutDuoi(45, '45'),
      PhutDuoi(46, '46'),
      PhutDuoi(47, '47'),
      PhutDuoi(48, '48'),
      PhutDuoi(49, '49'),
      PhutDuoi(50, '50'),
      PhutDuoi(51, '51'),
      PhutDuoi(52, '52'),
      PhutDuoi(53, '53'),
      PhutDuoi(54, '54'),
      PhutDuoi(55, '55'),
      PhutDuoi(56, '56'),
      PhutDuoi(57, '57'),
      PhutDuoi(58, '58'),
      PhutDuoi(59, '59'),
    ];
  }
}

class GioTren {
  int id;
  String name;

  GioTren(this.id, this.name);

  static List<GioTren> getCompanies() {
    return <GioTren>[
      GioTren(0, '0'),
      GioTren(1, '1'),
      GioTren(2, '2'),
      GioTren(3, '3'),
      GioTren(4, '4'),
      GioTren(5, '5'),
      GioTren(6, '6'),
      GioTren(7, '7'),
      GioTren(8, '8'),
      GioTren(9, '9'),
      GioTren(10, '10'),
      GioTren(11, '11'),
      GioTren(12, '12'),
      GioTren(13, '13'),
      GioTren(14, '14'),
      GioTren(15, '15'),
      GioTren(16, '16'),
      GioTren(17, '17'),
      GioTren(18, '18'),
      GioTren(19, '19'),
      GioTren(20, '20'),
      GioTren(21, '21'),
      GioTren(22, '22'),
      GioTren(23, '23'),
    ];
  }
}


class PhutTren {
  int id;
  String name;

  PhutTren(this.id, this.name);

  static List<PhutTren> getCompanies() {
    return <PhutTren>[
      PhutTren(0, '0'),
      PhutTren(1, '1'),
      PhutTren(2, '2'),
      PhutTren(3, '3'),
      PhutTren(4, '4'),
      PhutTren(5, '5'),
      PhutTren(6, '6'),
      PhutTren(7, '7'),
      PhutTren(8, '8'),
      PhutTren(9, '9'),
      PhutTren(10, '10'),
      PhutTren(11, '11'),
      PhutTren(12, '12'),
      PhutTren(13, '13'),
      PhutTren(14, '14'),
      PhutTren(15, '15'),
      PhutTren(16, '16'),
      PhutTren(17, '17'),
      PhutTren(18, '18'),
      PhutTren(19, '19'),
      PhutTren(20, '20'),
      PhutTren(21, '21'),
      PhutTren(22, '22'),
      PhutTren(23, '23'),
      PhutTren(24, '24'),
      PhutTren(25, '25'),
      PhutTren(26, '26'),
      PhutTren(27, '27'),
      PhutTren(28, '28'),
      PhutTren(29, '29'),
      PhutTren(30, '30'),
      PhutTren(31, '31'),
      PhutTren(32, '32'),
      PhutTren(33, '33'),
      PhutTren(34, '34'),
      PhutTren(35, '35'),
      PhutTren(36, '36'),
      PhutTren(37, '37'),
      PhutTren(38, '38'),
      PhutTren(39, '39'),
      PhutTren(40, '40'),
      PhutTren(41, '41'),
      PhutTren(42, '42'),
      PhutTren(43, '43'),
      PhutTren(44, '44'),
      PhutTren(45, '45'),
      PhutTren(46, '46'),
      PhutTren(47, '47'),
      PhutTren(48, '48'),
      PhutTren(49, '49'),
      PhutTren(50, '50'),
      PhutTren(51, '51'),
      PhutTren(52, '52'),
      PhutTren(53, '53'),
      PhutTren(54, '54'),
      PhutTren(55, '55'),
      PhutTren(56, '56'),
      PhutTren(57, '57'),
      PhutTren(58, '58'),
      PhutTren(59, '59'),
    ];
  }
}

class BangThietBi {
  int id;
  String name;

  BangThietBi(this.id, this.name);
  static List<BangThietBi> getCompanies() {
    return <BangThietBi>[
      BangThietBi(1, 'TB1'),
      BangThietBi(2, 'TB2'),
    ];
  }
}

class _MyAppState extends State<HomePage> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  PageController _pageController;
  int _page = 0;
  String titleBar         = 'IOT NODE JS';
  var _userNameErr = "Tài khoản không hợp lệ hoặc dưới 6 kí tự";
  var _passErr = "Mật khẩu không hợp lệ hoặc dưới 6 kí tự";
  var _userInvalid = false;
  var _passInvalid = false;

  String nhietdo = "0";
  String doam = "0";
  String anhsang = "0";
  String biencam = "0";

  int trangthairelay1 = 0;
  int trangthairelay2 = 0;
  String textbutton1 = "OFF";
  String textbutton2 = "OFF";
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


  Socket socket;
  String DataSendSocket = "";
  String DataReceived = "";



  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  List<BangThietBi> _BangThietBi = BangThietBi.getCompanies();
  List<DropdownMenuItem<BangThietBi>> _MenuItemsBangThietBi;
  BangThietBi _selectedBangThietBi;

  List<GioDuoi> _GioDuoi = GioDuoi.getCompanies();
  List<DropdownMenuItem<GioDuoi>> _MenuItemsGioDuoi;
  GioDuoi _selectedGioDuoi;

  //PhutDuoi
  List<PhutDuoi> _PhutDuoi = PhutDuoi.getCompanies();
  List<DropdownMenuItem<PhutDuoi>> _MenuItemsPhutDuoi;
  PhutDuoi _selectedPhutDuoi;

  //GioTren
  List<GioTren> _GioTren = GioTren.getCompanies();
  List<DropdownMenuItem<GioTren>> _MenuItemsGioTren;
  GioTren _selectedGioTren;

  //PhutTren
  List<PhutTren> _PhutTren = PhutTren.getCompanies();
  List<DropdownMenuItem<PhutTren>> _MenuItemsPhutTren;
  PhutTren _selectedPhutTren;

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
              icon: Icon(Icons.account_balance),
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
              title: Text('Hẹn Giờ'),
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
              color: Colors.lightBlue,
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
              color: Colors.limeAccent,
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


                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),

                      Text("ĐỘ PH1",
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

                      Text("ĐỘ PH2",
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
                          child: Text('$textbutton1'),
                          onPressed: () {
                            setState(() {
                              //imagephong1 = "assets/off.jpg";
                              //status = true;
                              //isSwitched = true;
                            });
                            if(trangthairelay1 == 1)
                            {
                              setState(() {

                                publish("A0B");
                              });
                            }
                            else if(trangthairelay1 == 0)
                            {
                              setState(() {

                                publish("A1B");
                              });
                            }

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
                          image:AssetImage(imagephong2,),
                          height: 50,
                          width: 50,
                        ),
                        RaisedButton(
                          child: Text('$textbutton2'),
                          onPressed: () {
                            setState(()
                            {
                              //imagephong1 = "assets/on.jpg";
                              //status = false;
                              //isSwitched = false;
                            });
                            if(trangthairelay2 == 1)
                            {
                              setState(() {

                                publish("C0D");
                              });
                            }
                            else if(trangthairelay2 == 0)
                            {
                              setState(() {

                                publish("C1D");
                              });
                            }
                            //publish("C1D");
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
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                value: _selectedBangThietBi,
                items: _MenuItemsBangThietBi,
                onChanged: onChangeDropdownItemBangThietBi,
              ),
              SizedBox(width: 10),
              DropdownButton(
                value: _selectedGioDuoi,
                items: _MenuItemsGioDuoi,
                onChanged: onChangeDropdownItemGioDuoi,
              ),
              Text(':'),
              SizedBox(width: 10),
              DropdownButton(
                value: _selectedPhutDuoi,
                items: _MenuItemsPhutDuoi,
                onChanged: onChangeDropdownItemPhutDuoi,
              ),
              SizedBox(width: 10),
              Text("---"),
              SizedBox(width: 10),
              DropdownButton(
                value: _selectedGioTren,
                items: _MenuItemsGioTren,
                onChanged: onChangeDropdownItemGioTren,
              ),
              Text(':'),
              SizedBox(width: 10),
              DropdownButton(
                value: _selectedPhutTren,
                items: _MenuItemsPhutTren,
                onChanged: onChangeDropdownItemPhutTren,
              ),
              SizedBox(width: 10),

            ],
          ),
        ),

        RaisedButton(

          child: Text('Hẹn'),
          onPressed: (){
            print("Thiết bị: ${_selectedBangThietBi.id}");
            print("Giờ Dưới: ${_selectedGioDuoi.id}");
            print("Phút Dưới: ${_selectedPhutDuoi.id}");
            print("Giờ Trên: ${_selectedGioTren.id}");
            print("Phút Trên: ${_selectedPhutTren.id}");

          },
        ),


     /*
        Expanded(
          child: GridView.count(
            padding: EdgeInsets.all(30),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            crossAxisCount: 2,
            children: <Widget>[

            ],
          ),
        ),

      */
        /*
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text('Clear'),
            onPressed: (){
              print(_selectedCompany.name);
            },
          ),
        ),
        SizedBox(height:20),
        DropdownButton(
          value: _selectedCompany,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text('Selected: ${_selectedCompany.name}'),


         */

      ],

    );
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  onChangeDropdownItemBangThietBi(BangThietBi selectedCompany) {
    setState(() {
      _selectedBangThietBi = selectedCompany;
    });
  }

  onChangeDropdownItemGioDuoi(GioDuoi selectedCompany) {
    setState(() {
      _selectedGioDuoi = selectedCompany;
    });
  }

  onChangeDropdownItemPhutDuoi(PhutDuoi selectedCompany) {
    setState(() {
      _selectedPhutDuoi = selectedCompany;
    });
  }
 // GioDuoi
  onChangeDropdownItemGioTren(GioTren selectedCompany) {
    setState(() {
      _selectedGioTren = selectedCompany;
    });
  }
  //PhutTren
  onChangeDropdownItemPhutTren(PhutTren selectedCompany) {
    setState(() {
      _selectedPhutTren = selectedCompany;
    });
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
  //buildDropdownMenuItemsBangThietBi

  List<DropdownMenuItem<BangThietBi>> buildDropdownMenuItemsBangThietBi(List companies) {
    List<DropdownMenuItem<BangThietBi>> items = List();
    for (BangThietBi company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<GioDuoi>> buildDropdownMenuItemsGioDuoi(List companies) {
    List<DropdownMenuItem<GioDuoi>> items = List();
    for (GioDuoi company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
//PhutDuoi
  List<DropdownMenuItem<PhutDuoi>> buildDropdownMenuItemsPhutDuoi(List companies) {
    List<DropdownMenuItem<PhutDuoi>> items = List();
    for (PhutDuoi company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
  //GioTren
  List<DropdownMenuItem<GioTren>> buildDropdownMenuItemsGioTren(List companies) {
    List<DropdownMenuItem<GioTren>> items = List();
    for (GioTren company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  //PhutTren
  List<DropdownMenuItem<PhutTren>> buildDropdownMenuItemsPhutTren(List companies) {
    List<DropdownMenuItem<PhutTren>> items = List();
    for (PhutTren company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }


  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Start function');
    _pageController = PageController();
    //ConnectMQTT();

    super.initState();

    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;

    _MenuItemsBangThietBi = buildDropdownMenuItemsBangThietBi(_BangThietBi);
    _selectedBangThietBi = _MenuItemsBangThietBi[0].value;

    _MenuItemsGioDuoi = buildDropdownMenuItemsGioDuoi(_GioDuoi);
    _selectedGioDuoi = _MenuItemsGioDuoi[0].value;

    ////PhutDuoi
    _MenuItemsPhutDuoi = buildDropdownMenuItemsPhutDuoi(_PhutDuoi);
    _selectedPhutDuoi = _MenuItemsPhutDuoi[0].value;

    //GioTren
    _MenuItemsGioTren = buildDropdownMenuItemsGioTren(_GioTren);
    _selectedGioTren = _MenuItemsGioTren[0].value;

    //PhutTren
    _MenuItemsPhutTren = buildDropdownMenuItemsPhutTren(_PhutTren);
    _selectedPhutTren = _MenuItemsPhutTren[0].value;
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Start function');

    socket = io('http://192.168.1.25:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'foo': 'bar'} // optional
    });
    // kết nối server nodejs
    socket.connect();
    // lắng nghe sự kiện servr gửi về
    socket.on('app', (data)
    {
      print(data);
      DataReceived = data.toString();
      print("DataReceived:" '$DataReceived');
      ShowToask(DataReceived);

      print('nhietdo :${data['nhietdo']}');
      print('doam :${data['doam']}');
      print('anhsang :${data['anhsang']}');

      setState(() {
        nhietdo = data['nhietdo'];
        doam = data['doam'];
        anhsang = data['anhsang'];
      });

      setState(() {
        if(data['relay1'] == "1")
        {
          status = true;
          print(">>>>>>>>>>>>>>ON 1");
          trangthairelay1 = 1;
          imagephong1 = "assets/on.jpg";
          textbutton1 = "ON";
        }
        else if(data['relay1'] == "0")
        {
          status = false;
          print(">>>>>>>>>>>>>OFF 1");
          trangthairelay1 = 0;
          imagephong1 = "assets/off.jpg";
          textbutton1 = "OFF";
        }
      });

      setState(() {
        if(data['relay2'] == "1")
        {
          status = true;
          print(">>>>>>>>>>>>>>ON 2");
          trangthairelay2 = 1;
          imagephong2 = "assets/on.jpg";
          textbutton1 = "ON";

        }
        else if(data['relay2'] == "0")
        {
          status = false;
          print(">>>>>>>>>>>>>OFF 2");
          trangthairelay2 = 0;
          imagephong2 = "assets/off.jpg";
          textbutton1 = "OFF";
        }
      });


    });

    socket.on('connect', (_) {
      print('Connect server Nodejs - Socket io');
      ShowToask("Connect Server Node Js - Socket IO");
      DataSendSocket = "";
      DataSendSocket = "Hello Server";
      socket.emit('flutter', DataSendSocket);
    });
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Close function');

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

  void publish(String message){
    print('Data send:  ${message}');
    socket.emit('flutter', message);
  }

}
