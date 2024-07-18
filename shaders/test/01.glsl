#version 460 core

uniform float u_time;
uniform vec2 u_resolution;

out vec4 FragColor;

void main() {
    vec2 pos = gl_FragCoord.xy / u_resolution;
    FragColor = vec4(pos.x, pos.y, 0.0, 1.0);
}
