shader_type canvas_item;
render_mode unshaded;

uniform sampler2D gradient : source_color;
uniform float gradient_mix_amount = 1.0;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	uv -= pivot;
	// uses trig
	return vec2(cosa * uv.x - sina * uv.y, cosa * uv.y + sina * uv.x) + pivot;
}

void fragment() {
	vec2 uvRotate = rotateUV(UV, vec2(0.5, 0.5), radians(90));
	vec3 gradientTex = texture(gradient, uvRotate).rgb;
	float greyscale_val = dot(gradientTex.rgb, vec3(0.299, 0.587, 0.114));
	vec3 sampled_colour = texture(gradient, vec2(greyscale_val, 0.0)).rgb;
	COLOR.rgb = mix(gradientTex.rgb, sampled_colour, gradient_mix_amount);
	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR.a = pixelColor.a;
}
