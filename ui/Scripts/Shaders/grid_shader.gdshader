shader_type canvas_item;

uniform vec2 resolution = vec2(2000, 1454);
uniform vec3 lineColor : source_color = vec3(0.2, 0.3, 0.5);
uniform vec3 backgroundColor : source_color = vec3(0.1, 0.1, 0.1);
uniform float backgroundAlpha : hint_range(0.0, 1.0, 0.01) = 0.8;
uniform float zoom : hint_range(1.0, 50.0, 0.1) = 20.0;
uniform float thickness : hint_range(0.1, 10.0, 0.1) = 2.0;
uniform float brightness : hint_range(0.1, 4.0, 0.1) = 2.0;

float drawGrid(vec2 uv)
{
	vec2 gridUV = cos(uv * TAU);
	return max(gridUV.x, gridUV.y);
}

void fragment()
{
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;


	float lineThickness = zoom * thickness / resolution.y;

	vec3 gridColor = smoothstep(1.0 - lineThickness, 1.0, drawGrid(uv * zoom)) * lineColor;
	vec3 finalColor = mix(backgroundColor, gridColor * brightness, gridColor.r);


	COLOR = vec4(finalColor, backgroundAlpha);
}
