shader_type canvas_item;

uniform float time_offset = 0;
uniform float wiggle_mod = 1.0;
uniform bool pressed = false;

void vertex() {
	// Animate Sprite moving in big circle around its location
	VERTEX.y += cos((TIME * 4.) + time_offset * 3.) * (15. * wiggle_mod);
}