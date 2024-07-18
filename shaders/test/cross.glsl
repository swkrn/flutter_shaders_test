#version 460 core

uniform float time;
uniform vec2 resolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= resolution.x / resolution.y;

    float thickness = 0.05; // thickness of the cross

    // Calculate the distance to the two diagonals
    float d1 = abs(uv.x - uv.y);
    float d2 = abs(uv.x + uv.y);

    // Create the cross icon by combining the two diagonal lines
    float cross = smoothstep(thickness, thickness + 0.01, min(d1, d2));

    vec3 color = vec3(1.0 - cross);

    FragColor = vec4(color, 1.0);
}