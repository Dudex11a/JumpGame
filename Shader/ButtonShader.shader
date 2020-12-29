shader_type canvas_item;

void fragment() {
	// Only replace magenta
	if (COLOR == vec4(1, 0, 1, COLOR.a)) {
//		COLOR = vec4(0, 0, 1, COLOR.a);
		vec2 center = UV - vec2(0.1, 0.5);
		vec2 iRes = 1.0 / SCREEN_PIXEL_SIZE;
		center.x = center.x * (iRes.x / iRes.y);
		
		vec3 col = vec3(0.9, 0.3 + center.y, 0.5 + center.x);
		
		float r = 0.5;
		
		col *= smoothstep(r, r, length(center));
		
		COLOR = vec4(col, COLOR.a);
	}
}