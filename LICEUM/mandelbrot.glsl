const float maxIterations = 200.0;

vec2 kwadrat(vec2 number){
	return vec2(
		pow(number.x,2.0)-pow(number.y,2.0),
		2.0*number.x*number.y
	);
}


float Mandelbrot(vec2 liczba){
	
    vec2 zespolona = vec2(0,0);
   
	for(int i=0;i < int(maxIterations);i++)
    {
        // W KAŻDYM KROKU PRZEKSZTAŁĆ PUNKT zespolona 
        // WYKORZYSTAJ FUNKCJĘ KWADRAT
		zespolona = kwadrat(zespolona) + liczba;
		if(length(zespolona)>2.0) return float(i)/maxIterations;
	}
    
    
	return maxIterations;
}

vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
  return a + b * cos(6.28318 * (c * t + d));
}

vec3 paletteColor(float t) {
  vec3 a = vec3(0.5);
  vec3 b = vec3(0.5);
  vec3 c = vec3(1.0);
  vec3 d = vec3(0.3, 0.1, 0.1);
  return palette(fract(t + 0.5), a, b, c, d);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Współrzędne pikseli <0,1>
    vec2 uv = fragCoord/iResolution.xy;
    uv = (uv*2.0) - 1.0;
    
    // Stosunek długości do wysokości wyświetlacza
    float ratio = iResolution.x/iResolution.y;

    // Przeskalowanie osi X "rozciąga" oś X na cały wyświetlacz
    uv.x *= ratio;
    
    // zoom
    vec2 c = 4.0 * uv - vec2(-0.5,-0.5);
    c = c/pow(iTime,4.0) - vec2(0.65,0.45);
    
    
    // Output to screen
    float fractionalIteration = Mandelbrot(c);
    vec3 color = paletteColor(fractionalIteration);
    fragColor = vec4(color,1.0);
}