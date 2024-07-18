#version 460 core

uniform float u_time;
uniform vec2 u_resolution;

out vec4 FragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= u_resolution.x / u_resolution.y;

    float radius = 0.5; // radius of the circle
    float zoomDuration = 1.0; // zoom duration in seconds

    // Calculate the distance from the center
    float dist = length(uv);

    // Calculate the zoom factor
    float zoomFactor = 1.0;
    if (u_time < zoomDuration) {
        zoomFactor = 1.0 + u_time * (2.0 - 1.0); // Zoom in from 1.0 to 2.0 over 1 second
    }

    // Apply the zoom effect within the circle
    if (dist < radius) {
        uv /= zoomFactor;
    }

    // Convert back to [0, 1] range
    uv = (uv + 1.0) / 2.0;

    // Sample a color (here we just use a simple gradient for demonstration)
    vec3 color = vec3(uv, 0.5 + 0.5 * sin(u_time));

    FragColor = vec4(color, 1.0);
}