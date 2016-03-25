#version 430 core

in vec2 out_uv;

layout (location = 0)out vec4 color;


float beckmann(float ndoth, float m)
{
	float alpha = acos(ndoth);
	float ta = tan(alpha);
	float val = 1.0 / (m * m * pow(ndoth, 4.0)) * exp(-(ta * ta)/(m * m));
	return val;
}

float KSTextureCompute(vec2 texCoord)
{
	return 0.5 * pow(beckmann(texCoord.x, texCoord.y), 0.1);
}

void main()
{
	float beck = KSTextureCompute(out_uv);
	color = vec4(beck, beck, beck, 1.0);
}