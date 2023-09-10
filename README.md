<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width,initial-scale=1">
 <title>Bùi_Biên</title>
 <style>

*{
vertical-align: middle;
align-items: center;
justify-content: center;
color: rgba(255,255,255);
-webkit-appearance: none;
-webkit-user-select: none;
font-family: Arial, sans-serif;
font-size: 12px;
}

#ESPcanvas{
pointer-events: none;
z-index: -1;
background-color: rgba(0,255,0,0);
height: 100%;
width: 100%;
position: fixed;
top: 0px;
left: 0px;
}

#Mainmenu{
background-color: rgba(0 191 255);
height: 300px;
width: 450px;
position: fixed;
top: 20px;
left: calc(100% - 450px - 30px);
border-radius: 15px;
border: 1px solid white;
overflow: hidden;
}

#TitleBar{
text-align: center;
font-family: Menlo, monospace;
background-color: rgba(0 191 255);
color: rgba(0 0 0);
}
#TabBar{
margin-top: 3px;
display: flex;
border-bottom: 1px solid rgba(255,255,255);
}


.TabButton{
width: 20%;
background-color: rgba(200,200,200,0.6);
color: rgba(0,0,0);
border-radius: 7px 7px 0px 0px;
text-align: center;
}

.Tab{
display: none;
}

.Scroll{
white-space: nowrap;
height: calc(100% - 47px);
width: 100%;
overflow-x: hidden;
overflow-y: scroll;
}

input[type=button]{
color: rgba(255,255,255);
margin: 2.5px 2.5px;
border-radius: 5px;
border: 1px solid rgba(255,255,255,0.7);
width: 80px;
height: 20px;
background-color: rgba(200,200,200,0.4);
}

label input {
position: absolute;
opacity: 0;
}

label {
position: relative;
padding: 3px 0px 0px 25px;
line-height: 25px;
}

.checkmark {
position: absolute;
top: 0;
left: 0;
height: 20px;
width: 20px;
background-color: rgba(200,200,200,0.4);
border: 1px solid rgba(255,255,255,0.7);
}

label input:checked ~ .checkmark:after {
content: "";
position: absolute;
display: block;
left: 6px;
top: 1px;
width: 7px;
height: 12px;
border: solid rgba(255,255,255,0.7);
border-width: 0px 2px 2px 0px;
transform: rotate(45deg);
}

input[type=range] {
-webkit-appearance: none;
height: 20px;
width: 150px;
border-radius: 2px;
background: rgba(200,200,200,0.4);
border: 1px solid rgba(255,255,255,0.7);
}

input[type=range]::-webkit-slider-thumb {
height: 20px;
border: 0px;
border-radius: 2px;
-webkit-appearance: none;
height: 20px;
width: 15px;
background: rgba(255,255,255,0.7);
}

 </style>
</head>
<body>

<canvas id="ESPcanvas"></canvas>

<div id="Mainmenu">
 <div id="TitleBar"><span id="Title"></span></div>
<div id="TabBar">
<span class="TabButton" onclick="changeTab('1')">Basic</span>
<span class="TabButton" onclick="changeTab('2')">Support</span>
<span class="TabButton" onclick="changeTab('3')">Math</span>
<span class="TabButton" onclick="changeTab('4')">Info</span>
<span class="TabButton" onclick="changeTab('5')">Soon</span>
</div>

<div class="Tab" id=Tab_1><div class="Scroll">

<label>
<input type="checkbox" onclick="GlobalSpeed(this)">
<span class="checkmark"></span>
<span>Speedv1</span>
</label>
<input type="range" class="Slider" min="1" max="10" step="0.100" value="3.100"/>
<span class="SliderValue">3.100</span>
<br>
<label>
<input type="checkbox" onclick="WalkSpeed(this)">
<span class="checkmark"></span>
<span>Player Speed</span>
</label>
<input type="range" class="Slider" min="1" max="10" step="0.100" value="1.900"/>
<span class="SliderValue">1.900</span>
</div></div>

<div class="Tab" id=Tab_2><span><label>
<input type="checkbox" onclick="InfFly(this)">
<span class="checkmark"></span>
<span>Infly</span>
</label>
<label>
<input type="checkbox" onclick="HiddenClouds(this)">
<span class="checkmark"></span>
<span>Delete Clouds</span>
</label></span></div>
<div class="Tab" id=Tab_3><span>1.Bình Phương Của 1 Tổng:( A + B )^2= A^2 + 2AB + B^2
<br>
2.Bình Phương Của 1 Hiệu:( A - B )^2= A^2 - 2AB + B^2
<br>
3.Hiệu 2 Bình Phương: A^2 – B^2 = ( A – B )( A + B )
<br>
4.Lập Phương Của 1 Tổng:(A + B)^3 = A^3 + 3A^2B + 3AB^2 + B^3
<br>
5.Lập Phương Của 1 Hiệu:( A – B )^3 = A3 – 3A^2B + 3AB^2 – B^3.
<br>
6.Tổng Hai Lập Phương :A^3 + B^3 = ( A + B )( A^2 – AB + B^2 ).
<br>
7.Hiệu Hai Lập Phương :A^3 – B^3 = ( A – B )( A^2 + AB + B^2 ).
<br>
 7 Hằng Đẳng Thức Đáng Nhớ
<br>
Make By Bùi Biên😂
</span></div>
<div class="Tab" id=Tab_4><span>  <input type="button" value="DISCORD"style=height:28px  onclick="jr()"> 
                                  <input type="button" value="DISCORD"style=height:28px  onclick="jr1()"></div>
<div class="Tab" id=Tab_5><span>🥺</span></div>

</div>

<script>

//
var sWidth = 0
var sHeight = 0

var TitleBar = document.querySelector("#TitleBar");
var Mainmenu = document.querySelector("#Mainmenu");
var MainmenuRect = Mainmenu.getBoundingClientRect();
var TouchMoveOffset = {};
var TouchMovePos = {};
var Slider = document.getElementsByClassName("Slider");
var SliderValue = document.getElementsByClassName("SliderValue");


</script>

<script>

//
let layout = function(){
 setWindowDrag(0, 0, 0, 0);
 if(window.lastorientation==window.orientation) return;
 window.lastorientation=window.orientation;
 if (Math.abs(window.orientation) == 90) {
  sWidth = window.screen.height;
  sHeight = window.screen.width;
  setWindowRect(0,0,sWidth,sHeight);
 } else {
  sWidth = window.screen.width;
  sHeight = window.screen.height;
  setWindowRect(0,0,sWidth,sHeight);
 }
}

layout();
window.addEventListener("orientationchange", layout, false);

//
setButtonAction(function () {
 if (Mainmenu.style.display == 'none') {
  Mainmenu.style.display = 'block';
  setWindowTouch(true);
 } else {
  Mainmenu.style.display = 'none';
  setWindowTouch(false);
 }
});

</script>

<script>

//

TitleBar.addEventListener("touchstart", Touchstart, false);
TitleBar.addEventListener("touchmove", Movestart, false);

function Touchstart(e) {
 TouchMoveOffset = {
  X: e.pageX - Mainmenu.offsetLeft,
  Y: e.pageY - Mainmenu.offsetTop
 }
}

function Movestart(e) {
 TouchMovePos = {
  X: e.pageY - TouchMoveOffset.Y,
  Y: e.pageX - TouchMoveOffset.X
 }
 if (TouchMovePos.X < 0) TouchMovePos.X = 0;
 if (TouchMovePos.Y < 0) TouchMovePos.Y = 0;
 if (TouchMovePos.X > sHeight - Mainmenu.clientHeight) TouchMovePos.X = sHeight - Mainmenu.clientHeight;
 if (TouchMovePos.Y > sWidth - Mainmenu.clientWidth) TouchMovePos.Y = sWidth - Mainmenu.clientWidth;
 Mainmenu.style.top = TouchMovePos.X + "px";
 Mainmenu.style.left = TouchMovePos.Y + "px";
}

</script>

<script>

//
window.onload = loadFinished;
function loadFinished(){
//setButtonImage("");
TitleBar.innerText = SetTitleInfo()
}

function SetTitleInfo(){
 var AllModules = h5gg.getRangesList();
 var AppModuleName = AllModules[0].name;
 var AppName = AppModuleName.substr(AppModuleName.lastIndexOf("/") + 1)
 var Time = new Date();
 Time = {
  year: Time.getFullYear(),
  month: ('0' + (Time.getMonth() + 1)).slice(-2),
  date: ('0' + Time.getDate()).slice(-2),
 };
 return AppName+" Ngày "+Time.date+" Tháng "+Time.month+" Năm "+Time.year;
}

</script>

<script>

//
TabButton = document.getElementsByClassName("TabButton");
function changeTab(e){
  var elements = document.getElementsByClassName('Tab');
  for (var i = 0; i < elements.length; i++) {
    elements[i].style.display = "none";
  }
 document.querySelector("#Tab_"+e).style.display = "inline";
}

//
for (let i = 0; i < TabButton.length; i++) {
  TabButton[i].addEventListener("click", function () {
   for (let i = 0; i < TabButton.length; i++) {
    TabButton[i].style.backgroundColor = "rgba(200,200,200,0.6)";
   }
   TabButton[i].style.backgroundColor = "rgba(200,200,200,0.6)";
  }, false);
}

changeTab("1");
TabButton[0].style.backgroundColor = "rgba(255,255,255,0.7)";

</script>

<script>

//レンジスライダー関連
for (let i = 0; i < Slider.length; i++) {
 Slider[i].addEventListener("input", function () {
  SliderValue[i].innerText = Number(Slider[i].value).toFixed(3);
 }, false);
}

</script>



<script>

var BaseAddr = Number(h5gg.getRangesList(0)[0].start);
var Addr = {
 GlobalSpeed: readLong(BaseAddr + 0x1666380) + 0x1d0,
 WalkSpeed: BaseAddr + 0x16A1910,
 InfFly: BaseAddr + 0x166516C,
 HiddenClouds: BaseAddr + 0x1665168
};

//0x16A1E50 羽上昇
//0x1666380 -> 0x1d0 全体加速

function GlobalSpeed(e){
 if(e.checked){
  ChangeGlobalSpeed = setInterval(function (){
   h5gg.setValue(Addr.GlobalSpeed,Number(Slider[0].value), 'F32');
  }, 1000/60);
 }else{
 clearInterval(ChangeGlobalSpeed);
 h5gg.setValue(Addr.GlobalSpeed,"1", 'F32');
 }
}

function WalkSpeed(e){
 if(e.checked){
  ChangeWalkSpeed = setInterval(function (){
   h5gg.setValue(Addr.WalkSpeed,Number(Slider[1].value) * 3.5, 'F32');
  }, 1000/60);
 }else{
 clearInterval(ChangeWalkSpeed);
 h5gg.setValue(Addr.WalkSpeed,"3.5", 'F32');
 }
}

function InfFly(e){
 if(e.checked){
 h5gg.setValue(Addr.InfFly,"2.6", 'F32');
 }else{
 h5gg.setValue(Addr.InfFly,"2.5", 'F32');
 }
}

function HiddenClouds(e){
 if(e.checked){
 h5gg.setValue(Addr.HiddenClouds,"0", 'I8');
 }else{
 h5gg.setValue(Addr.HiddenClouds,"1", 'I8');
 }
}

function readLong(addr) {
 return Number(h5gg.getValue(addr, "I64"));
}
  function jr1(){
alert('cvv')
  }
   function jr(){
alert('cvvvvv')
  }
</script>


</body>
</html>
