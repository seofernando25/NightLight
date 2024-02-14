shader_type canvas_item;

uniform vec2 size = vec2(1.0, 1.0);

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture,filter_nearest;

void fragment() {
	vec2 norm_size = size * SCREEN_PIXEL_SIZE;
	vec2 uv = round(SCREEN_UV / norm_size) * norm_size;

    // Output the color
    COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
    
}



//shader_type canvas_item;
//
//uniform vec2 size = vec2(32.0, 28.0);
//// If you intend to read from mipmaps with `textureLod()` LOD values greater than `0.0`,
//// use `filter_nearest_mipmap` instead. This shader doesn't require it.
//uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest_mipmap;
//
//void fragment() {
        //vec2 norm_size = size * SCREEN_PIXEL_SIZE;
        //bool half = mod(SCREEN_UV.y / 2.0, norm_size.y) / norm_size.y < 0.5;
        //vec2 uv = SCREEN_UV + vec2(norm_size.x * 0.5 * float(half), 0.0);
        //vec2 center_uv = floor(uv / norm_size) * norm_size;
        //vec2 norm_uv = mod(uv, norm_size) / norm_size;
        //COLOR = textureLod(screen_texture, center_uv, 0.0);
//}