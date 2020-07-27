shader_type canvas_item;

uniform vec3 color1 = vec3(0.4, 0.7, 1.);
uniform vec3 color2 = vec3(0.5, 0.5, 0.9);

float sawtooth(float a, float freq) {
    if (mod(a, freq) < freq * 0.5) return mod(a, freq * 0.5);
    return freq * 0.5 - mod(a, freq * 0.5);
}

void fragment() {
	// First Part
	vec3 first = vec3(mod(abs(sawtooth(UV.x, 0.6) + sawtooth(UV.y, 0.6) + TIME * 0.3), 0.4)) * color2;
	COLOR = vec4(first, 1.);
	
	// Second Part
	vec2 uv2 = UV;
	uv2.x += sin(uv2.y * 4.0 + TIME) * 0.1;
	if (mod(abs(uv2.x + uv2.y + TIME * 0.2), 0.2) < 0.1) {
		vec3 lines = vec3(cos(UV.x * 2.0 + TIME * 2. + UV.y * 3.0)) * vec3(color1) * 0.7;
		COLOR = mix(COLOR, vec4(lines, 1.), 0.5);
	}
	
	COLOR = mix(COLOR, vec4(color1, 1.), 0.9);
}