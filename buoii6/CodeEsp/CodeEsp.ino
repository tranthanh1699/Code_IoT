 #include <ESP8266WiFi.h>
#include <SocketIoClient.h>


extern bool connect;
const char* ssid     = "Bao Truc";
const char* password = "24682468";

// Server Ip
const char* server = "192.168.1.25";
// Server port
int port = 3000;

SocketIoClient socket;


String JsonData = "";
int nhietdo = 0;
int doam = 0;
int anhsang = 0;
unsigned long last = 0;
int trangthairelay1 = 0;
int trangthairelay2 = 0;
String Data = "";
int bien1 = 0;
int bien2 = 0;

void setupNetwork()
{
  WiFi.begin(ssid, password);
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println("Wifi connected!");
}

void handleMessage(const char* message , size_t length)
{
  last = millis();
  Serial.print("message:");
  Serial.println(message);
  Data = message;
  // xử lý dữ liệu
  // gửi qua uno
  // mySerial.println(Data);

  if (Data.indexOf("A0B") >= 0)
  {
    Serial.println("OFF thiết bị 1");
    digitalWrite(2, HIGH);
    trangthairelay1 = 0;
  }
  else if (Data.indexOf("A1B") >= 0)
  {
    Serial.println("ON thiết bị 1");
    digitalWrite(2, LOW);
    trangthairelay1 = 1;
  }

  if (Data.indexOf("C0D") >= 0)
  {
    Serial.println("OFF thiết bị 2");
    digitalWrite(16, HIGH);
    trangthairelay2 = 0;
  }
  else if (Data.indexOf("C1D") >= 0)
  {
    Serial.println("ON thiết bị 2");
    digitalWrite(16, HIGH);
    trangthairelay2 = 1;
  }

  chuongtrinhcambien();
  SendDataMQTT(String(nhietdo), String(doam), String(anhsang), String(trangthairelay1), String(trangthairelay2));
  last = millis();
}
void setup()
{
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  digitalWrite(16, HIGH);
  setupNetwork();
  // kết nối server nodejs
  socket.begin(server, port);
  // lắng nghe sự kiện server gửi
  socket.on("message", handleMessage);
  last = millis();
  Serial.println("ESP Start");
}

void loop()
{
  socket.loop();

  if (millis() - last >= 3000)
  {
    if (connect)
    {
      chuongtrinhcambien();
      SendDataMQTT(String(nhietdo), String(doam), String(anhsang), String(trangthairelay1), String(trangthairelay2));
    }
    last = millis();
  }

}

void chuongtrinhcambien()
{
  nhietdo++;
  doam = doam + 2;
  anhsang = anhsang + 3;
}

void SendDataMQTT( String sensor1 ,  String sensor2 ,  String sensor3 , String sensor4 , String sensor5)
{
  JsonData = "";
  JsonData = "{\"nhietdo\":\"" + String(sensor1) + "\"," +
             "\"doam\":\"" + String(sensor2) + "\"," +
             "\"anhsang\":\"" + String(sensor3) + "\"," +
             "\"relay1\":\"" + String(sensor4) + "\"," +
             "\"relay2\":\"" + String(sensor5) + "\"}";

  socket.emit("JSON", JsonData.c_str());
}
