shader_type canvas_item;

uniform sampler2D image;

void fragment() {
	// Replace everything that isn't the border with THE STUFF
	if (COLOR != vec4(vec3(0.0), COLOR.a)) {
		// Add image
		COLOR = texture(image, UV);
		// Darken bottom part so information is easier to read
		if (UV.y > 0.5) {
			COLOR *= 0.5;
		}
	}
}