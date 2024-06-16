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

var animate = function() {
    
    
    
};

/* cp  填充颜色黑色，用于fillRect */
ctx.fillStyle = '#FFFFFF';
ctx.fillRect( 0, 0, w, h );

/* cp 每16ms重绘 */
setInterval( animate, 16 );

