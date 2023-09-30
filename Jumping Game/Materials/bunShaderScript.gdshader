shader_type spatial;

uniform float ramp_value : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    // Interpolate between red and yellow based on ramp_value
    COLOR = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(1.0, 1.0, 0.0, 1.0), ramp_value);
}