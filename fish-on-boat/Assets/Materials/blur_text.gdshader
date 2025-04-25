shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 5.0;

void fragment() {
    vec4 sum = vec4(0.0);
    vec2 size = vec2(blur_amount) / vec2(textureSize(TEXTURE, 0));
    
    for (float x = -2.0; x <= 2.0; x += 1.0) {
        for (float y = -2.0; y <= 2.0; y += 1.0) {
            sum += texture(TEXTURE, UV + vec2(x, y) * size);
        }
    }
    
    COLOR = sum / 25.0;
}