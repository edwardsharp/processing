int w=1280,sx=0,x,y,z;void setup(){size(w,320,P2D);noCursor();} void draw(){for(background(y=0);y++<w;)for(x=0;x++<w;)set(y,x,~get(x&mouseX,y&mouseY));}
