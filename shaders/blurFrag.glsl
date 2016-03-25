#version 430 core

in vec2 out_uv;

uniform sampler2D tex;
uniform float globalTime;
uniform vec2 globalResolution;

layout (location = 0)out vec4 color;

#define ITER 32
#define SIZE 16.0

void srand(vec2 a, out float r)
{
	r=sin(dot(a,vec2(1233.224,1743.335)));
}

float rand(inout float r)
{
	r=fract(3712.65*r+0.61432);
	return (r-0.5)*2.0;
}

void mainImage(in vec2 fragCoord)
{
	vec2 uv = fragCoord;
	float p=SIZE/globalResolution.y*(sin(globalTime/2.0)+1.0);
	vec4 c=vec4(0.0);
	float r;
	srand(uv, r);
	vec2 rv;
	
	for(int i=0;i<ITER;i++)
	{
		rv.x=rand(r);
		rv.y=rand(r);
		c+=texture2D(tex,-uv+rv*p)/float(ITER);
	}
	color = c;
}

void main()
{
	vec2 uv = vec2(out_uv.x, 1.0 - out_uv.y);
	mainImage(uv);
}