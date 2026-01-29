shader_type canvas_item;

uniform vec2 player_pos;
uniform vec2 pos;
uniform float angle;

void vertex() {
	vec2 diff = pos - player_pos;

	float cos_angle = cos(angle);
	float sin_angle = sin(angle);
	mat2 rot_matrix = mat2(vec2(cos_angle, -sin_angle), vec2(sin_angle, cos_angle));
	diff *= rot_matrix;
	//diff += player_pos;
	//diff -= pos;

	VERTEX += diff;

	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = vec4(0.1, 0.8, 0.5, 1.);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
