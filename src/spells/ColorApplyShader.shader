shader_type canvas_item;

uniform vec4 color_base;
uniform vec4 color_outline;

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel

	if (curr_color == vec4(1,1,1,1) ) {
        COLOR = color_base;
    } else {
		if (curr_color == vec4(0,0,0,1) ) {
			COLOR = color_outline;
		} else {
			COLOR = curr_color;
		}
	}


}