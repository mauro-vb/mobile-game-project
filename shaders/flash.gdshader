shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(1,1,1,1);
uniform vec4 color : source_color;
uniform float flashState : hint_range(0,1) = 0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV) * base_color;
	COLOR = mix(pixelColor, color, flashState);
	COLOR.a *= pixelColor.a;

}