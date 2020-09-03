shader_type canvas_item;

uniform vec3 hsv = vec3(1, 1, .5);

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
//	float cmax = max(COLOR.r, COLOR.b);
//	cmax = max(cmax, COLOR.g);
//	float cmin = min(COLOR.r, COLOR.b);
//	cmin = min(cmax, COLOR.g);
	
	// Found this here https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786#gistcomment-3195243
	// Hue shift
	float hue = hsv[0] * 6.28318;
	const vec3 k = vec3(0.57735, 0.57735, 0.57735);
    float cosAngle = cos(hue);
    COLOR = vec4(COLOR.rgb * cosAngle + cross(k, COLOR.rgb) * sin(hue) + k * dot(k, COLOR.rgb) * (1.0 - cosAngle), COLOR.a);
	
	float value = hsv[2] * 2.;
	COLOR.r *= value;
	COLOR.g *= value;
	COLOR.b *= value;
	
}