#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266HTTPClient.h>
const char *ssid = "Bao Truc";
const char *pass = "24682468";
uint8_t LED1 = 2;
uint8_t LED2 = 16;

long last = 0;
int nhietdo = 0;
int doam = 0;
int anhsang = 0;
int trangthairelay1 = 0;
int trangthairelay2 = 0;
int bien1 = 0;
int bien2 = 0;
int bien = 0;
int controlden1 = 0;
int controlden2 = 0;
void setup()
{
  delay(1000);
  Serial.begin(9600);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  digitalWrite(LED2, HIGH);
  delay(1000);
  WiFi.begin(ssid, pass);
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  digitalWrite(LED1, LOW);
  last = millis();
  delay(1000);
  Serial.println("Start");
}

void loop()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    if (millis() - last > 500)
    {
      Read_DieuKhien_PHP();
      chuongtrinhcambien();
      Send_Data_PHP( String(nhietdo) , String(doam) , String(anhsang) , String(trangthairelay1) , String(trangthairelay2));
      last = millis();
    }
  }
}

void chuongtrinhcambien()
{
  nhietdo++;
  doam = doam + 2;
  anhsang = anhsang + 3;
}
void Send_Data_PHP(String nhietdo , String doam , String anhsang , String relay1 , String relay2)
{
  HTTPClient http;
  //http.begin("http://ip:port//folder chứa file InsertDB.php ( htdocs) /InsertDB.php");

  //http://192.168.1.25:80//DatabasePHP/InsertDB.php
  http.begin("http://192.168.1.25:80//DatabasePHP/InsertDB.php");
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  String httpRequestData = "nhietdo="   + String(nhietdo)
                           + "&doam=" +  String(doam)
                           + "&anhsang="  + String(anhsang)
                           + "&relay1="  + String(relay1)
                           + "&relay2="  + String(relay2)
                           + "";
  // hiển thị dữ liệu request
  bien1++;
  Serial.print(bien1);
  Serial.print(".Data Send PHP:");
  Serial.println(httpRequestData);
  // Send HTTP POST request về databasephp
  int httpResponseCode = http.POST(httpRequestData);
  // nếu đưa dữ liệu thành công httpResponseCode == 200
  // nếu không đưa dữ liệu dc httpResponseCode == -1
  if (httpResponseCode > 0)
  {
    //Serial.print("HTTP Response code: ");
    //Serial.println(httpResponseCode);
    Serial.println("Send Data Thành Công");
    digitalWrite(LED2, LOW);
    delay(200);
    digitalWrite(LED2, HIGH);
  }
  else
  {
    Serial.print("Error: ");
    Serial.println(httpResponseCode);
  }
  http.end();
  //=================================================================================
}


void Read_DieuKhien_PHP()
{
  HTTPClient http;
  const char* host = "http://192.168.1.25:80//DatabasePHP/Getdatadieukhien.php";
  http.begin(host);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  int httpCode = http.GET();

  // nếu lấy thành công httpCode = 200
  if (httpCode == 200)
  {
    bien++;
    String payload = http.getString();
    Serial.print(bien);
    Serial.print(".Data Read PHP:");
    Serial.println(payload);
    //=======================================
    // khung data điều khiển A[thiết bị 1]B[thietbi2]C[text1]D[text2]E
    // A1B => ON đèn 1 , A0B => OFF đèn 1

    // kiểm tra có sự thay đổi không => nếu có thì thực hiện
    
    if (payload.indexOf("A0B") >= 0)
    {
      Serial.println("OFF đèn 1");
      trangthairelay1 = 0;

    }
    else if (payload.indexOf("A1B") >= 0)
    {
      Serial.println("ON đèn 1");
      trangthairelay1 = 1;
    }
    
    //=======================================
  }
  http.end();
}
