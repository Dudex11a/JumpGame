shader_type canvas_item;

uniform vec2 node_size = vec2(200., 60.);
uniform float radius = 0.0;
uniform vec2 mouse_pos = vec2(.5);
uniform float circle_alpha = 1.0;

vec4 circle(vec2 uv, vec2 pos, float rad, vec3 color) {
	float d = length(pos - uv) - rad;
	float t = clamp(d, 0.0, 1.0);
	return vec4(color, 1.0 - t);
}

void fragment() {
	// Only replace magenta
	if (COLOR != vec4(0, 0, 0, COLOR.a) && radius > 0.0) {
		vec2 center = node_size * mouse_pos;
		float circle_radius = radius * node_size.x;
		vec3 circle_color = vec3(COLOR.r, COLOR.g, COLOR.b);
		circle_color += 0.4;
		vec4 circle = circle(UV * node_size, center, circle_radius, circle_color);
		COLOR = mix(COLOR, circle, circle.a * circle_alpha);
	}
}