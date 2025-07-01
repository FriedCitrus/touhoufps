shader_type spatial;

void fragment() {
    vec2 uv = UV * 200.0; // 10x10 grid // world-based tiling, adjust the scale
    vec2 grid = abs(fract(uv - 0.5) - 0.5) / fwidth(uv);
    float line = min(grid.x, grid.y);
    ALBEDO = mix(vec3(1.0), vec3(0.0), smoothstep(0.0, 1.0, line));
}
