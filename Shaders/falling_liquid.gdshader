shader_type spatial;
render_mode blend_mix, depth_draw_opaque;

uniform sampler2D liquid_texture : source_color, filter_nearest;
uniform float speed : hint_range(0.0, 1) = 1.0;
uniform vec2 uv_scale = vec2(0.3, 0.3);

varying vec3 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    // 1. Create the base UV from world coordinates
    vec2 base_uv = world_pos.xz * uv_scale.x; // Use XZ for horizontal wrapping
    base_uv.y = world_pos.y * uv_scale.y;    // Use Y for vertical height

    // 2. APPLY DOWNWARD MOVEMENT
    // Change '+' to '-' if you want it to move upward instead
    base_uv.y += TIME * speed;

    // 3. Wavy Distortion
    // We calculate offsets based on the base_uv to create a "wobble"
    vec2 uv_offset;

    // 4. Final Texture Lookup
    vec4 tex = texture(liquid_texture, base_uv);

    ALBEDO = tex.rgb;
    ALPHA = 0.5;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
