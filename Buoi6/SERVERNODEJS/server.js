console.log("Server Start");

// tạo server nodejs
var express = require("express");
var app = express();
app.set("view engine","ejs");
app.set("views","./views"); // tạo file views trong file server , file views chạy file viết hmtl , html.ejs
var server = require("http").Server(app);
var io = require("socket.io").listen(server);



//====================================
// Open server node js và emit/on data client
var myport = process.env.PORT || 3000;

server.listen(myport, function () {
    console.log('Server listening at port %d', myport);
});


function ParseJson(jsondata) {
  try {
      return JSON.parse(jsondata);
  } catch (error) {
      return null;
  }
}
// Receive data from esp8266
io.on("connection", function(socket) {
  console.log("Có người truy cập id:" + socket.id);
   
  socket.on("disconnect",function(){
		
		console.log(socket.id + " ngat ket noi!!!!");
	});
	
  // lắng nghe html send data 
  socket.on("htmlclient", function(data) {
    console.log("html id:" + socket.id + " Sendata:" + data);
	// gửi xuống cho esp
	io.emit("message", data);
  });
  
  // lắng nghe dữ liệu esp gửi vê
  socket.on("JSON", function(data) {
	var jsonStr = JSON.stringify(data);
	var parsed = ParseJson(jsonStr);
	console.log(parsed);
	// gửi cho web
	io.emit("web", data);
	// gửi về cho app flutter
	io.emit("app", data);
  });
  
  // lắng nghe app flutter gửi
  socket.on("flutter", function(data) {
    console.log("flutter id:" + socket.id + " sendata:" +data);
	// gửi xuống cho esp
	io.emit("message", data);
  });
  
});

app.get("/",function(req,res){
	res.render("html");
});




