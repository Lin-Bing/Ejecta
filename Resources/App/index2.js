/*

    INSTRUCTIONS:
    This file must be copied into ./App in order to work

*/

var w = window.innerWidth;
var h = window.innerHeight;
var scale = window.devicePixelRatio;
var w2 = w/2;
var h2 = h/2;

/* cp 调整canvas尺寸为全屏
 */
var canvas = document.getElementById('canvas');
canvas.width = w * scale;
canvas.height = h * scale;
canvas.style.width = w;
canvas.style.height = h;

var ctx = canvas.getContext('2d');
ctx.scale(scale, scale);



/* cp 绘制文本  */
var animate = function() {
    ctx.fillStyle = '#0000FF';
    ctx.fillRect(0,0,w,h);
    ctx.fillStyle = '#FF0000';
    ctx.font = "50px";
    ctx.fillText("Hello world", 50, 90);
};
/* cp 每16ms重绘 */
//setInterval( animate, 16 );



/* cp 绘制图片 */
const image = new Image();
image.src = "https://webglfundamentals.org/webgl/resources/leaves.jpg";
image.load = function(){
    console.log("image loaded");
};
image.error = function(){
    console.log("image error");
};
image.addEventListener("load", (e) => {
    console.log("image load");
  ctx.drawImage(image, 21, 20, 87, 104);
});



/* cp  填充颜色 */
ctx.fillStyle = '#0000FF';
ctx.fillRect( 0, 0, w, h );


/* cp 绘制离屏画布 */
// 创建离屏 canvas 元素
const offscreenCanvas = document.createElement('canvas');
const offscreenContext = offscreenCanvas.getContext('2d');

// 设置离屏 canvas 的大小
offscreenCanvas.width = 200;
offscreenCanvas.height = 200;

// 在离屏 canvas 上绘制内容
offscreenContext.fillStyle = 'red';
offscreenContext.fillRect(0, 0, 200, 200);

offscreenContext.fillStyle = 'white';
offscreenContext.font = '30px Arial';
offscreenContext.fillText('Offscreen', 50, 100);

// 将离屏 canvas 的内容绘制到屏幕上的 canvas
ctx.drawImage(offscreenCanvas, 100, 200);




