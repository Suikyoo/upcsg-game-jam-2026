shader_type canvas_item;

uniform vec4 chroma_color : source_color;
uniform vec4 outline_color : source_color; // Color of the outline
uniform float outline_thickness : hint_range(1.0, 100.0); // Thickness of the outline
uniform vec2 outline_offset;
uniform vec2 SCREEN_SIZE;

bool check_color(vec4 a, vec4 b) {
	vec3 diff = a.rgb - b.rgb;
	for (int i=0; i<3; i++) {
		if (diff[i] > 0.001) {
			return false;
		}
	}
	return true;
}
vec4 convert_chroma(vec4 color) {
	if (check_color(color, chroma_color)) {
        return vec4(0.);
    }
	return color;
}
void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    // If the current pixel is transparent, check surrounding pixels for color
	original_color = convert_chroma(original_color);

	if (original_color.a == 0.0) {
        vec4 color = vec4(0.0); // Default to transparent

        // Check surrounding pixels
        for (float x = -outline_thickness; x <= outline_thickness; x += 1.0) {
            for (float y = -outline_thickness; y <= outline_thickness; y += 1.0) {
                vec2 offset = (vec2(x, y) + outline_offset) / SCREEN_SIZE.xy;
                vec4 check_color = texture(TEXTURE, UV + offset);
				check_color = convert_chroma(check_color);
                if (check_color.a > 0.0) {
                    color = outline_color; // Set to outline color if any surrounding pixel is non-transparent
                    break;
                }
            }
        }
        COLOR = color; // Assign outline color if a neighboring color is found
    } else {
        COLOR = original_color; // Retain the original color otherwise
	}
}
