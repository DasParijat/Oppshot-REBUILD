shader_type canvas_item;

// uniform vec4 flash_button;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(0,0,0).rgb, 0.5);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
