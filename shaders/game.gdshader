shader_type canvas_item;

uniform vec2 SCREEN_SIZE;
uniform float darkness: hint_range(0.0, 1.0);
uniform float danger: hint_range(0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 orig_color = texture(TEXTURE, UV);
	
	vec4 color = vec4(0.);
	
	vec2 center = vec2(0.5);
	float dist = distance(UV, center);
	
	if (dist > 0.5 * (1. - darkness)) {
		
		color = vec4(vec3(0.), 1.);
	}
	//color += vec4(0.2, 0.01, 0., danger * 0.1 * cos(TIME));
	color = clamp(color, vec4(0.), vec4(1.));
	COLOR = color;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
