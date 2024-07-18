#version 460 core

uniform vec2 uSize;
uniform vec4 uColor;

out vec4 FragColor;

void main() {
    FragColor = uColor;
}