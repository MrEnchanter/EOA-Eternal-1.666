//based on D4D glory kill shader
uniform float timer; 
vec4 Process(vec4 color)
{
	vec2 texCoord = gl_TexCoord[0].st;
	vec4 orgColor = getTexel(texCoord) * color;
	
	float cp = (sin(pixelpos.y/10-timer*8)+1)/2; //float cp = (sin(pixelpos.y/4-timer*8)+1)/2;
	vec2 fragCoord = gl_FragCoord.xy/2;
	
	// polkadot alpha
	float cpd = float(int(fragCoord.x)%2 == 0   &&  int(fragCoord.y)%2 == 0);
	cp = clamp((cp*cpd)-0.2, 0.0, 1.0);
	
	// RGB color of glow, components from 0.0 to 1.0.
	vec3 glowColor = vec3(2.0, 0.75, 0.15);
	vec3 dkColor = ((orgColor.rgb-0.5)*1.8)+0.5;
	
	return vec4(mix(dkColor, glowColor, cp*cpd), orgColor.a);
}
