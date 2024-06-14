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

/* cp 初始化贝塞尔曲线属性，数量为200
 */
var curves = [];
for( var i = 0; i < 200; i++ ) {
    curves.push({
        current: Math.random() * 1000,
        inc: Math.random() * 0.005 + 0.002,
        color: '#'+(Math.random()*0xFFFFFF<<0).toString(16) // Random color
    });
}

/* cp 贝塞尔曲线控制点4个 (x,y)
*/
var p = [0,0, 0,0, 0,0, 0,0];
var animate = function() {
    // Clear the screen - note that .globalAlpha is still honored,
    // so this will only "darken" the sceen a bit
    
    /* cp 清除画布
    由于globalAlpha是0.05，fillStyle为黑色，采用source-over覆盖合成模式，最终效果就是把原来画布上的内容变暗0.05
     */
    ctx.globalCompositeOperation = 'source-over';
    ctx.fillRect(0,0,w,h);

        
    /* cp 绘制贝塞尔曲线
    采用lighter颜色相加合成模式，在现有画布上绘制新内容，实现叠加效果，最终就是之前绘制的内容慢慢变暗，新绘制的内容最亮，叠加就产生了渐变效果
     */
    // Use the additive blend mode to draw the bezier curves
    ctx.globalCompositeOperation = 'lighter';

    // Calculate curve positions and draw
    for( var i = 0; i < maxCurves; i++ ) {
        /* cp 产生贝塞尔曲线控制点、颜色 */
        var curve = curves[i];
        curve.current += curve.inc;
        for( var j = 0; j < p.length; j+=2 ) {
            var a = Math.sin( curve.current * (j+3) * 373 * 0.0001 );
            var b = Math.sin( curve.current * (j+5) * 927 * 0.0002 );
            var c = Math.sin( curve.current * (j+5) * 573 * 0.0001 );
            p[j] = (a * a * b + c * a + b) * w * c + w2;
            p[j+1] = (a * b * b + c - a * b *c) * h2 + h2;
        }

        /* cp 绘制贝塞尔曲线 */
        ctx.beginPath();
        ctx.moveTo( p[0], p[1] );
        ctx.bezierCurveTo( p[2], p[3], p[4], p[5], p[6], p[7] );
        ctx.strokeStyle = curve.color;
        ctx.stroke();
    }
};


/* cp 拖动切换绘制效果
 x轴控制线条宽度
 y轴控制曲线数量
 */
// The vertical touch position controls the number of curves;
// horizontal controls the line width
var maxCurves = 70;
document.addEventListener( 'touchmove', function( ev ) {
    ctx.lineWidth = (ev.touches[0].pageX/w) * 20;
    maxCurves = Math.floor((ev.touches[0].pageY/h) * curves.length);
}, false );


/* cp  填充颜色黑色，用于fillRect */
ctx.fillStyle = '#000000';
ctx.fillRect( 0, 0, w, h );
/* cp 全局透明度0.05
目的是用于在animate进行效果叠加
 */
ctx.globalAlpha = 0.05;
ctx.lineWidth = 2;

/* cp 每16ms重绘 */
setInterval( animate, 16 );

