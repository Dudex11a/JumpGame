shader_type canvas_item;

uniform vec2 node_size = vec2(200., 60.);
uniform float radius = 0.0;
uniform vec2 mouse_pos = vec2(.5);

vec4 circle(vec2 uv, vec2 pos, float rad, vec3 color) {
	float d = length(pos - uv) - rad;
	float t = clamp(d, 0.0, 1.0);
	return vec4(color, 1.0 - t);
}

void fragment() {
	// Only replace magenta
	if (COLOR == vec4(1, 0, 1, COLOR.a)) {
		vec4 layer1 = vec4(vec3(.2), COLOR.a);
		
		vec2 center = node_size * mouse_pos;
		float circle_radius = radius * node_size.x;
		vec3 l2_color = vec3(.4, .4, .4);
		vec4 layer2 = circle(UV * node_size, center, circle_radius, l2_color);
		COLOR = mix(layer1, layer2, layer2.a);
	}
}