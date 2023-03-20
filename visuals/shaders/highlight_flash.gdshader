shader_type spatial;

uniform vec3 highlight_color : source_color = vec3(0.92, 0.7, 0.04);
uniform float highlight_alpha = 0.8;
uniform float flash_speed = 7.0;

void fragment() {
	float val = sin(TIME * flash_speed) * 0.5 + 0.5;
	ALBEDO = highlight_color;
	ALPHA = clamp(highlight_alpha * val, 0.1, 1);
}