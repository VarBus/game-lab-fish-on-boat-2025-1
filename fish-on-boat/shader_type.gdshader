shader_type canvas_item;

uniform float speed = 0.5;
uniform float wave_height = 10.0;
uniform float frequency = 0.1;
uniform vec4 water_color : source_color = vec4(0.3, 0.6, 0.9, 0.7);

void fragment() {
    vec2 uv = UV;
    uv.y += sin(uv.x * frequency + TIME * speed) * wave_height * 0.01;
    
    COLOR = water_color;
    COLOR.a *= smoothstep(0.0, 0.2, uv.y); // Transparencia en la parte inferior
}