shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform sampler2D liquid_texture : source_color, filter_nearest;
uniform float speed : hint_range(0.0, 0.5) = 1.0;
uniform float amplitude : hint_range(0.0, 0.1) = 0.02;
uniform float frequency : hint_range(0.0, 20.0) = 10.0;
uniform vec2 uv_scale = vec2(0.3, 0.3);

varying vec3 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 base_uv = world_pos.xz * uv_scale;

	vec2 uv_offset;
    uv_offset.x = sin(base_uv.y * frequency + TIME * speed) * amplitude;
    uv_offset.y = cos(base_uv.x * frequency + TIME * speed) * amplitude;

    vec4 tex = texture(liquid_texture, base_uv + uv_offset);
	ALBEDO = tex.rgb;
	ALPHA = 0.5;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
