<?php

?>
<!DOCTYPE html>
<html lang="en">

<head>
   
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
	
	 <title>LỚP HỌC IOT</title>
    <!-- CONTROL BUTTON BOM - QUAT - DEN -->
	
<style>
	
		html,body{
  display: grid;
  height: 100%;
  text-align: center;
  place-items: center;
  background: #808080;
}
.range{
  height: 80px;
  width: 380px;
  background: #fff;
  border-radius: 10px;
  padding: 0 65px 0 45px;
  box-shadow: 2px 4px 8px rgba(0,0,0,0.1);
}
.sliderValue{
  position: relative;
  width: 100%;
}
.sliderValue span{
  position: absolute;
  height: 45px;
  width: 45px;
  transform: translateX(-70%) scale(0);
  font-weight: 500;
  top: -40px;
  line-height: 55px;
  z-index: 2;
  color: #fff;
  transform-origin: bottom;
  transition: transform 0.3s ease-in-out;
}
.sliderValue span.show{
  transform: translateX(-70%) scale(1);
}
.sliderValue span:after{
  position: absolute;
  content: '';
  height: 100%;
  width: 100%;
  background: #664AFF;
  border: 3px solid #fff;
  z-index: -1;
  left: 50%;
  transform: translateX(-50%) rotate(45deg);
  border-bottom-left-radius: 50%;
  box-shadow: 0px 0px 8px rgba(0,0,0,0.1);
  border-top-left-radius: 50%;
  border-top-right-radius: 50%;
}
.field{
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  position: relative;
}
.field .value{
  position: absolute;
  font-size: 18px;
  color: #664AFF;
  font-weight: 600;
}
.field .value.left{
  left: -22px;
}
.field .value.right{
  right: -43px;
}
.range input{
  -webkit-appearance: none;
  width: 100%;
  height: 3px;
  background: #ddd;
  border-radius: 5px;
  outline: none;
  border: none;
  z-index: 2222;
}
.range input::-webkit-slider-thumb{
  -webkit-appearance: none;
  width: 20px;
  height: 20px;
  background: red;
  border-radius: 50%;
  background: #664AFF;
  border: 1px solid #664AFF;
  cursor: pointer;
}
.range input::-moz-range-thumb{
  -webkit-appearance: none;
  width: 20px;
  height: 20px;
  background: red;
  border-radius: 50%;
  background: #664AFF;
  border: 1px solid #664AFF;
  cursor: pointer;
}
	</style>
    <script>

        // chedo
        function FunctionButton1()
        {
           // var Tx_den1 = $('#den1').val(); 
            //var Tx_den2 = $('#den2').val(); 
           // var Tx_text1 = $('#text1').val(); 
           // var Tx_text2 = $('#text2').val(); 
		   var dataden1 = document.getElementById("trangthairelay1").innerHTML;
		   
		   console.log(dataden1);
		   if(dataden1 == "OFF")
		   {
			   var Tx_den1 = "1"; 
		   }
		   else
		   {
			   var Tx_den1 = "0"; 
		   }
		   
           var Tx_den2 = "1"; 
           var Tx_text1 = "333"; 
           var Tx_text2 = "444"; 
		      
		   

            $.ajax({
                type: "POST",
                url: 'update.php',
                dataType: 'json',
                data: {
                    den1: Tx_den1,
                    den2: Tx_den2,
                    text1: Tx_text1,
                    text2: Tx_text2,
                },
            });
            console.log(Tx_den1);
            console.log(Tx_den2);
            console.log(Tx_text1);
            console.log(Tx_text2);
        }
        
		
		function sendtext1()
		{
			var Tx_text1 = document.getElementById("ssid").value;
		   
		   console.log(Tx_text1); 
		   
		   var Tx_den1 = "1";
           var Tx_den2 = "1"; 
           var Tx_text2 = "444"; 
		      
		   

            $.ajax({
                type: "POST",
                url: 'update.php',
                dataType: 'json',
                data: {
                    den1: Tx_den1,
                    den2: Tx_den2,
                    text1: Tx_text1,
                    text2: Tx_text2,
                },
            });
            console.log(Tx_den1);
            console.log(Tx_den2);
            console.log(Tx_text1);
            console.log(Tx_text2);
			
		}
    </script>

<script>
function startTime()
 {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if ( xhr.readyState == 4 ) 
		{
            console.log(JSON.parse( xhr.responseText ));
            var Datajson = JSON.parse( xhr.responseText);
            console.log(Datajson);
			var nhietdo = Datajson.nhietdo;
			console.log("nhiệt độ:" +nhietdo);   
			var doam = Datajson.doam;
			console.log("Độ ẩm:" +doam); 
			
			//document.getElementById("nhietdo").innerHTML = Datajson.nhietdo;
			
			if(Datajson.relay1 == 0)
			{
				// ON 
				document.getElementById("trangthairelay1").innerHTML = "OFF";
			}
			else
			{
				//OFF
				document.getElementById("trangthairelay1").innerHTML = "ON";
				
			}
        }
    }
    xhr.open('GET', 'read-data-web.php', true);
    xhr.send();
    var t = setTimeout(function(){ startTime() }, 500);
}
</script>
</head>

<body onload="startTime()">

<h1> text1:
	<label id="trangthairelay1">ON</label>	
 </h1>
<button onclick = "FunctionButton1()" type="button">Click Me Button 1!</button>
  </br>  
  <button onclick = "FunctionButton2()" type="button">Click Me Button 2!</button>
  </br>

  
  <h1> text1:
	<input id="ssid"/>
	<button id="button_save"  onclick="sendtext1()">Send text 1</button>
 </h1>

	<h1>text2: 
		<input id="pass"/>
		<button id="button_save2"  onclick="sendtext2()">Send text 2</button>
		
	</h1>
	
	<div class="range">
		
		<div class="field">
			<div class="value left">0</div>
			<input id="myRange" type="range" min="0" max="200" value="0" steps="1" oninput="num.value = this.value" >	
			<div class="value right">
			<output id="num">0</output>
			</div>
		</div>
		</br>
		</br>
		<button id="button_save3"  onclick="myFunctionRange()">Send range</button>
		
	</div>
	
	</br>
	</br>
  
  

</body>



</html>