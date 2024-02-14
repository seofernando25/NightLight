shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Uniforms equivalent in Godot
uniform sampler2D ampMap0;
uniform sampler2D ampMap1;
uniform sampler2D zoomMap;

// Zoom
uniform float zoom_displacement_speed = 0.5;
uniform float zoom_intensity = 0.0;

// Wobble
uniform float wobble_speed = 0.2;
uniform float wobble_intensity = 0.1;

// Warp
uniform float warp_speed = 0.2;
uniform float warp_intensity = 0.1;


uniform float displacement_amplitude = 0.5;
uniform float afWaveAlpha;

void fragment() {
	vec2 screen_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    
    vec4 vAmp = texture(ampMap0, SCREEN_UV) * (1.0 - displacement_amplitude) + texture(ampMap1, SCREEN_UV) * displacement_amplitude;
    
    vec4 zoom_frag = texture(zoomMap, SCREEN_UV);
    
    vec2 vUV = SCREEN_UV;
    
	vec2 zoom_displacement = (zoom_frag.xy - vec2(0.5)) * 0.6 * zoom_frag.y *  zoom_intensity;
	
	vUV += zoom_displacement * ( sin(TIME * zoom_displacement_speed) + 1.0);
	
  // Leminiscate-ish wobble
	float x_wobble =  4.0 * sin(TIME * wobble_speed);
	float y_wobble = sin(1.83 * TIME * wobble_speed);
	vec2 wobble_uv = vec2(x_wobble, y_wobble);
	
    vUV += wobble_uv * 0.0025 * wobble_intensity;
	
	
 	vec2 vSinUv = (vUV / screen_size.y) * 0.6;
	vec2 amp_displacement = vec2(
		sin(warp_speed * TIME + vSinUv.y) * vAmp.x,
		sin(warp_speed * TIME + vSinUv.x*1.83) * vAmp.y
	);
	vUV += amp_displacement * 0.05 * warp_intensity;
	
    
   
    COLOR =  texture(SCREEN_TEXTURE,  vUV  );
	
}
