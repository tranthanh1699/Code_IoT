import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'message.dart';
import 'send_message.dart';

void main()
{
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
}
class _MyAppState extends State<HomePage> {

  bool _showPass = false;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  PageController _pageController;
  int _page = 0;
  String titleBar         = 'IOT SMART HOME MQTT';
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

  String trangthairelay1 = "ON";

  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;

  StreamSubscription subscription;

  TextEditingController brokerController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController identifierController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  Set<String> topics = Set<String>();
  List<Message> messages = <Message>[];
  ScrollController messageController = ScrollController();

  String CheckMQTT = "Disconnect";
  String Connect = "Connect";
  int biencheckMqtt = 0;


  bool isSwitched = false;
  String valueSwich = "OFF";
  bool status = false;

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

        floatingActionButton: _page == 2
            ? Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.redAccent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (BuildContext context) =>
                        SendMessageDialog(client: client),
                    fullscreenDialog: true,
                  ));
            },
          );
        })
            : null,

        bottomNavigationBar: BottomNavigationBar(
          onTap: navigationTapped,
          currentIndex: _page,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              title: Text('Sensor'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              title: Text('Control'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
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
              color: Colors.lightGreenAccent,
              child: _buildBrokerPage(connectionStateIcon),
            ),
            Container(color: Colors.orange,
              child: _buildSubscriptionsPage(),
            ),
            Container(color: Colors.tealAccent,
              child: _buildMessagesPage(),
            ),

          ],
        ),

      ),
    );
  }

  Column _buildBrokerPage(IconData connectionStateIcon) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),

        RaisedButton(
          onPressed: (_Click_ConnectMQTT), // hàm onclick //onPressed: changedata,
          color: Colors.cyan,
          splashColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15.0 , horizontal: 25.0),
          child: Text('$Connect',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text("$data" ),
        RaisedButton(
          child: Text('Click Button '),
          onPressed: onButtonPress,
        ),
        SizedBox(height: 30),
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
                    SizedBox(height: 5),

                    Text("NHIỆT ĐỘ",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    // Icon(Icons.adb , size: 70.0,),
                    SizedBox(height: 20),
                    Image(image:AssetImage('assets/8.jpg',),),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("$nhietdo", style: TextStyle(fontSize: 25 , color: Colors.blue),),
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
                    SizedBox(height: 20),
                    Image(
                      image:AssetImage('assets/9.jpg',),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("$doam", style: TextStyle(fontSize: 25, color: Colors.blue),),
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
                    SizedBox(height: 20),
                    Image(
                      image:AssetImage('assets/12.jpg',),

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("$anhsang", style: TextStyle(fontSize: 25 , color: Colors.blue),),
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

                    Text("PHÒNG D",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),
                    //Icon(Icons.android , size: 70.0,),
                    SizedBox(height: 20),
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
                    Text("ABC",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),
                    //Icon(Icons.android , size: 70.0,),
                    SizedBox(height: 20),
                    Image(
                      image:AssetImage('assets/11.jpg',),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("$biencam", style: TextStyle(fontSize: 25 , color: Colors.blue),),
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

  Column _buildMessagesPage() {
    return Column(

      children: <Widget>[

        Expanded(
          child: ListView(
            controller: messageController,
            children: _buildMessageList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text('Clear'),
            onPressed: () {
              setState(() {
                messages.clear();
              });
            },
          ),
        )
      ],
    );
  }

  Column _buildSubscriptionsPage() {

    return Column(



      children: <Widget>[
        SizedBox(height: 40),

        Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Text("ĐIỀU KHIỂN THIẾT BỊ",
              style: TextStyle(
                fontSize: 30, color: Colors.red,
              ),
            ),
          ],
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

        RaisedButton(
          child: Text('SEND TEXT 1'),
          onPressed: (SendText1),
        ),
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
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('ON 1'),
                          onPressed: () {
                            publish("A1B");
                          },
                        ),
                        SizedBox(width: 10),
                        RaisedButton(
                          child: Text('OFF 1'),
                          onPressed: () {
                            publish("A0B");
                          },
                        ),
                        Text("$trangthairelay1" ),
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
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('ON 2'),
                          onPressed: () {
                            publish("C1D");
                          },
                        ),
                        SizedBox(width: 10),
                        RaisedButton(
                          child: Text('OFF 2'),
                          onPressed: () {
                            publish("C0D");
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

                    Text("PHÒNG C",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('OFF 1'),
                          onPressed: () {
                            publish("OFF1");
                          },
                        ),
                        SizedBox(width: 10),
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

                    Text("PHÒNG D",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('OFF 1'),
                          onPressed: () {
                            publish("OFF1");
                          },
                        ),
                        SizedBox(width: 10),
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

                    Text("PHÒNG E",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        FlutterSwitch(
                          width: 125.0,
                          height: 55.0,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: status,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
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

                    Text("PHÒNG F",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                        Text(
                          '$valueSwich',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0),
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

                    Text("CÀI ĐẶT",
                      style: TextStyle(
                        fontSize: 20, color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('SEND TEXT 1'),
                          onPressed: () {

                            publish("OFF1");
                          },
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

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }


  List<Widget> _buildMessageList() {
    return messages
        .map((Message message) => Card(
      color: Colors.white70,
      child: ListTile(
        trailing: CircleAvatar(
            radius: 14.0,
            backgroundColor: Theme.of(context).accentColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'QoS',
                  style: TextStyle(fontSize: 8.0),
                ),
                Text(
                  message.qos.index.toString(),
                  style: TextStyle(fontSize: 8.0),
                ),
              ],
            )),
        title: Text(message.topic),
        subtitle: Text(message.message),
        dense: true,
      ),
    ))
        .toList()
        .reversed
        .toList();
  }

  List<Widget> _buildTopicList() {
    // Sort topics
    final List<String> sortedTopics = topics.toList()
      ..sort((String a, String b) {
        return compareNatural(a, b);
      });
    return sortedTopics
        .map((String topic) => Chip(
      label: Text(topic),
      onDeleted: () {
        _unsubscribeFromTopic(topic);
      },
    ))
        .toList();
  }


  void SendText1()
  {
    print(_userController.text);
    String Datagui = "";
    Datagui = "E" + _userController.text + "F";
    print(Datagui);
    publish(Datagui);

  }
  void _Click_ConnectMQTT() async
  {
    setState(() {
      //ConnectMQTT();
      if(Connect == 'Connect')
      {
        //Connect = 'Disconnect';
        ConnectMQTT();

      }
      else
      {
        //Connect = 'Connect';
        _disconnect();

      }
    });
  }

  void ConnectMQTT() async{
    //client = mqtt.MqttClient('mqtt.ngoinhaiot.com', '');
   // client.port = 1111;
    //client.logging(on: true);
    //client.keepAlivePeriod = 30;
   // client.onDisconnected = _onDisconnected;
    client = mqtt.MqttClient(mqtt_server, '');
    client.port = mqtt_port;
    client.logging(on: true);
    client.keepAlivePeriod = 30;
    client.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean()
        .keepAliveFor(30)
        .withWillTopic('DisconnectMQTT')
        .withWillMessage('DisconnectMQTT')
        .withWillQos(mqtt.MqttQos.atMostOnce);
    client.connectionMessage = connMess;
    try
    {
      //await client.connect('toannv10291', 'toannv10291');
      await client.connect(mqtt_user, mqtt_pass);
    }
    catch (e)
    {
      print(e);
      _disconnect();

    }
    if (client.connectionState == mqtt.MqttConnectionState.connected) {

      setState(()
      {
        connectionState = client.connectionState;
        client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
        print('CONNECT MQTT AND SUBSCRIBE TOPIC: $topic');
      });
    }
    else
    {
      _disconnect();
      print('Connection failed , state is ${client.connectionState}');

    }
    subscription = client.updates.listen(_onMessage);
  }

  void _disconnect() {
    client.disconnect();
    _onDisconnected();
    print('Disconnect Broker MQTT');

  }

  void _onDisconnected() {
    setState(()
    {

    });
    print('Disconnect Broker MQTT');

  }
  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    // hàm nhận dũ liệu từ server mqtt
    final mqtt.MqttPublishMessage recMess = event[0].payload as mqtt.MqttPublishMessage;
    final String message =  mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('MQTT message:${message}');
    data = message;
    print('Data :${data}');
    // xử lý dữ liệu json

    var DataJsonObject = json.decode(data);

    print('nhietdo :${DataJsonObject['nhietdo']}');
    print('doam :${DataJsonObject['doam']}');
    print('anhsang :${DataJsonObject['anhsang']}');

    setState(() {
      nhietdo = DataJsonObject['nhietdo'];
      doam = DataJsonObject['doam'];
      anhsang = DataJsonObject['anhsang'];
    });

    //status
    setState(() {
      if(DataJsonObject['relay1'] == "1")
      {
        status = true;
        print(">>>>>>>>>>>>>>ON 1");
        trangthairelay1 = "ON";
      }
      else if(DataJsonObject['relay1'] == "0")
      {
        status = false;
        print(">>>>>>>>>>>>>OFF 1");
        trangthairelay1 = "OFF";
      }
    });

    setState(() {
      messages.add(Message(
        topic: event[0].topic,
        message: message,
        qos: recMess.payload.header.qos,
      ));
      try {
        messageController.animateTo(
          0.0,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      } catch (_) {
      }
    });
  }

  void _subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      setState(() {
        if (topics.add(topic.trim())) {
          print('Subscribing to ${topic.trim()}');
          client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
        }
      });
    }
  }

  void _unsubscribeFromTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      setState(() {
        if (topics.remove(topic.trim())) {
          print('Unsubscribing from ${topic.trim()}');
          client.unsubscribe(topic);
        }
      });
    }
  }
 void onButtonPress()
 {

 }
  void publish(String message){
    if (connectionState == mqtt.MqttConnectionState.connected)
    {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topicapp, MqttQos.exactlyOnce, builder.payload);
      print('Data send:  ${message}');

    }
  }
}
