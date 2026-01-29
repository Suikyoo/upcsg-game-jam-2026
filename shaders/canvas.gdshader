shader_type canvas_item;

uniform vec4 chroma_color : source_color;
uniform vec4 bg_color : source_color;

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
void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    // If the current pixel is transparent, check surrounding pixels for color
    if (check_color(original_color, chroma_color)) {
        vec4 color = bg_color;
            
       
        COLOR = color; // Assign outline color if a neighboring color is found
    } else {
        COLOR = original_color; // Retain the original color otherwise
    }
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
