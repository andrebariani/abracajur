shader_type canvas_item;

uniform vec4 color_blink;

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	
    COLOR = vec4(color_blink.r, color_blink.g, color_blink.b, curr_color.a);
}