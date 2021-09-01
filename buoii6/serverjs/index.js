console.log("Server Start - Nodejs");

var express = require("express");
var app = express();

app.use(express.static('public'));
app.use('/images',express.static(__dirname + 'public/images'));

app.set("view engine","ejs");
app.set("views","./views"); // tạo file views trong file server , file views chạy file viết hmtl , html.ejs
var server = require("http").Server(app);
var io = require("socket.io").listen(server);

var myport = process.env.PORT || 3000;

server.listen(myport, function () {
    console.log('Server listening at port %d', myport);
});



io.on("connection", function(socket) {
  console.log("Có người truy cập id:" + socket.id);
  
  // hàm kiểm tra client disconnect
  socket.on("disconnect",function(){
		
		console.log(socket.id + " ngat ket noi!!!!");
	});
	
	
	// lắng nghe sự kiện app flutter
	  socket.on("flutter", function(data) {
    console.log("AppFlutter id:" + socket.id + " Sendata:" + data);
	// gửi xuống cho esp
	io.emit("message", data);
  });
	
	// lắng nghe html send data 
  socket.on("htmlclient", function(data) {
    console.log("Html id:" + socket.id + " Sendata:" + data);
	// gửi xuống cho esp
	io.emit("message", data);
  });
  
  
  	// lắng nghe esp
  socket.on("JSON", function(data) {  
	var DataJson = JSON.stringify(data);
	console.log("ESP ID:" + socket.id + " Sendata:" + DataJson);
	// gửi cho web	
	io.emit("web", data);
	
	// gửi cho app flutter	
	
	io.emit("app", data);
	
	console.log(data.nhietdo);
	console.log(data.doam);
	console.log(data.anhsang);
	console.log(data.relay1);
	console.log(data.relay2);
	
	
	var nhietdo = data.nhietdo;
	var doam = data.doam;
	var anhsang = data.anhsang;
	var relay1 = data.relay1;
	var relay2 = data.relay2;
		
	//code lấy ngày và giò
	let date_ob = new Date();
	let date = ("0" + date_ob.getDate()).slice(-2);
	let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
	let year = date_ob.getFullYear();
	let hours = date_ob.getHours();
	let minutes = date_ob.getMinutes();
	let seconds = date_ob.getSeconds();
	var ngay =  year + "-" + month + "-" + date;
	console.log(ngay);
	var thoigian = hours + ":" + minutes + ":" + seconds;
	console.log(thoigian);
	
	var mysql = require('mysql');
	var con = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "",
	database: "dataesp3"
	});

	con.connect(function(err) 
	{
		if (err) throw err;
		console.log("Connected MySQL XAMPP");
		
		//Insert a record in the "customers" table:
		var sql = "INSERT INTO phpdata (nhietdo, doam, anhsang, relay1 , relay2 , Date , Time) VALUES ('"+nhietdo+"', '"+doam+"','"+anhsang+"','"+relay1+"','"+relay2+"','"+ngay+"','"+thoigian+"')";
		con.query(sql, function (err, result) 
		{
			if (err) throw err;
			console.log("Save Data MySQL XAMPP Thành Công");
		});
		
		
		con.end();
		
	});
	
	
  });
		
});


app.get("/",function(req,res){
	//res.render("html");
	res.render("index");
});