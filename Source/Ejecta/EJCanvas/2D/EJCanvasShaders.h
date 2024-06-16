// OpenGL Vertex and Fragment Shader sources for all Canvas2D rendering
// operations. The Vertex Shader is the same for all ops.

// The compilation of these Shaders happens lazily in the global
// EJShardeOpenGLContext to ensure that they only have to be compiled once.

#define EJ_SHADER_SOURCE(NAME, ...) const char * const NAME = #__VA_ARGS__;

/* cp 顶点着色器源码
 */
EJ_SHADER_SOURCE(EJShaderVertex,
	attribute vec2 pos;
	attribute vec2 uv;
	attribute vec4 color;

	varying lowp vec4 vColor;
	varying highp vec2 vUv;

	uniform highp vec2 screen;

	void main() {
		vColor = color;
		vUv = uv;
		
		gl_Position = vec4(pos * (vec2(2,2)/screen) - clamp(screen,-1.0,1.0), 0.0, 1.0);
	}
);

/* cp fs 透明纹理，取纹理的透明通道，与颜色相乘
 */
EJ_SHADER_SOURCE(EJShaderAlphaTexture,
	varying lowp vec4 vColor;
	varying highp vec2 vUv;

	uniform sampler2D texture;

	void main() {
		gl_FragColor = texture2D(texture, vUv).aaaa * vColor;
	}
);

/* cp fs， 只有颜色
 */
EJ_SHADER_SOURCE(EJShaderFlat,
	varying lowp vec4 vColor;
	varying highp vec2 vUv;

	void main() {
		gl_FragColor = vColor;
	}
);

/* cp fs，平铺
 取模操作可以让纹理循环重复，从而创建出平铺的纹理效果
 */
EJ_SHADER_SOURCE(EJShaderPattern,
	varying lowp vec4 vColor;
	varying highp vec2 vUv;

	uniform sampler2D texture;

	void main() {
		gl_FragColor = texture2D(texture, mod(vUv, vec2(1.0, 1.0)) ) * vColor;
	}
);

/* cp fs 纹理 * 颜色
 */
EJ_SHADER_SOURCE(EJShaderTexture,
	varying lowp vec4 vColor;
	varying highp vec2 vUv;

	uniform sampler2D texture;

	void main() {
		gl_FragColor = texture2D(texture, vUv) * vColor;
	}
);

/* cp fs 径向渐变???
 */
EJ_SHADER_SOURCE(EJShaderRadialGradient,
	precision highp float;

	varying highp vec2 vUv;
	varying lowp vec4 vColor;

	uniform mediump vec3 inner; // x, y, z=radius
	uniform mediump vec3 diff; // x, y, z=radius

	uniform sampler2D texture;

	void main() {
		vec2 p2 = vUv - inner.xy;
		
		float A = dot(diff.xy, diff.xy) - diff.z * diff.z;
		float B = dot(p2.xy, diff.xy) + inner.z * diff.z;
		float C = dot(p2, p2) - (inner.z * inner.z);
		float D = (B * B) - (A * C);
		
		float DA = sqrt(D) / A;
		float BA = B / A;
		
		float t = max(BA+DA, BA-DA);
		
		lowp float keep = sign(diff.z * t + inner.z); // discard if < 0.0
		gl_FragColor = texture2D(texture, vec2(t, 0.0)) * vColor * keep;
	}
);

