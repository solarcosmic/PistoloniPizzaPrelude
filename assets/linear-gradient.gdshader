shader_type canvas_item;
render_mode unshaded;
uniform sampler2D gradient_texture;
uniform vec2 size;

varying vec2 iuv;

void vertex() {
    iuv = VERTEX.xy / size;
}

void fragment() {
    COLOR.rgb = texture(gradient_texture, vec2(iuv.y, 0.0)).rgb;
    COLOR.a = texture(TEXTURE, UV).a;
}
