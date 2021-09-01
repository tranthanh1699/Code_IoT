#include <ESP8266WiFi.h>
#include <SocketIoClient.h>


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
  Serial.print("message:");
  Serial.println(message);
  Data = message;
  // xử lý dữ liệu???
   // A1B ON 1 , A0B OFF1
  if (Data.indexOf("A1B") >= 0)
  {
    Serial.println("ON thiết bị 1");
    digitalWrite(16, HIGH);
    trangthairelay1 = 1;
  }
  else if (Data.indexOf("A0B") >= 0)
  {
    Serial.println("OFF thiết bị 1");
    digitalWrite(16, LOW);
    trangthairelay1 = 0;
  }
  // C1D ON 2 , C0D OFF 2
  else if (Data.indexOf("C1D") >= 0)
  {
    Serial.println("ON thiết bị 2");
    digitalWrite(2, HIGH);
    trangthairelay2 = 1;
  }
  else if (Data.indexOf("C0D") >= 0)
  {
    Serial.println("OFF thiết bị 2");
    digitalWrite(2, LOW);
    trangthairelay2 = 0;
  }
  // xử lý dữ liệu
  // E[dữ liệu]F
  /*
        Bước 1: tìm kí tự A B trong chuỗi gửi xuống
        Bước 2: Tách dữ liệu
        Bước 3: gán dữ liệu cho 1 cái biến
  */
  //EF
  int TimE, TimF = -1;
  TimE = Data.indexOf("E");
  TimF = Data.indexOf("F");
  if (TimE >= 0 && TimF >= 0)
  {
    String text1 = "";
    text1 = Data.substring(TimE + 1 , TimF);
    bien1 = text1.toInt();
    Serial.println(bien1);
  }

  //GH
  int TimG, TimH = -1;
  TimG = Data.indexOf("G");
  TimH = Data.indexOf("H");
  if (TimG >= 0 && TimH >= 0)
  {
    String text2 = "";
    text2 = Data.substring(TimG + 1 , TimH);
    bien2 = text2.toInt();
    Serial.println(bien2);
  }

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
    chuongtrinhcambien();
    SendDataMQTT(String(nhietdo), String(doam), String(anhsang), String(trangthairelay1));
    last = millis();
  }

}

void chuongtrinhcambien()
{
  nhietdo++;
  doam = doam + 2;
  anhsang = anhsang + 3;
}

void SendDataMQTT( String sensor1 ,  String sensor2 ,  String sensor3 , String sensor4 )
{
  JsonData = "";
  JsonData = "{\"nhietdo\":\"" + String(sensor1) + "\"," +
             "\"doam\":\"" + String(sensor2) + "\"," +
             "\"anhsang\":\"" + String(sensor3) + "\"," +
             "\"relay1\":\"" + String(sensor4) + "\"}";

  Serial.print("JsonData:");
  Serial.println(JsonData);
  socket.emit("JSON", JsonData.c_str());
}
