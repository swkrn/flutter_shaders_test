#version 460 core

uniform float u_time;
uniform vec2 u_resolution;

out vec4 FragColor;

// Plot a line on Y using a value between 0.0 - 1.0
float plot(vec2 st) {
    return smoothstep(0.02, 0, abs(st.y - st.x));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    float y = st.x;

    vec3 color = vec3(y);

    // Plot a line
    float pct = plot(st);
    color = (1 - pct) * color + pct * vec3(0.0, 1.0, 0.0);

    FragColor = vec4(color, 1.0);
}