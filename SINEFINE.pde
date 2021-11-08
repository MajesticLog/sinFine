/*
Code by Zoe Caudron @life.as.a.plant
Made as a beginner exercise for a Processing class
Constraints were: only global variables, no if statements or loops
Some interactions via mouse and/or keyboard
*/

//----------------------------------------- GLOBAL VARIABLES -----------------------------------------

int num;
float x, y, mX, mY;  // positions for the global translate to mid-screen and nested translates
float angle=0;
float diam;         // diameter of the first drawing circle + calculates smaller circle's diameters
float step;          // base increment so each nested rotation differs from the first
float fullR;        // First global rotation, so the alignment of the shape drawn varies with each sketch
float r, g, b, a;    // Colours!
float sinX, cosX;    // determine the multipliers of sin and cos for mX and mY. If the random values are similar, the shape will be close to circular

//----------------------------------------------- SETUP ----------------------------------------------

void setup() {
  
  size(1000, 1000);      // square sketch
  background(0);
  frameRate(30);
  x=width/2;    // middle of the screen's width
  y=height/2;    // middle of the screen's height
  smooth();      // anti-aliasing

  a=random(5, 10);    // keeps a low alpha
  r=random(255);      // r, g, b and a are initialised randomly; clicking the mouse will assign new random values
  g=random(255);
  b=random(255);

  /* 
  sinX and cosX pick random values from a random range with similar mins and max. 
  If close (like 100 and 115), the shape will look like a circle. If very different (ex 100 and 300), the shape will look more like an 8
  */
  sinX=random(100, 300);    
  cosX=random(100, 300);
  step=random(30, 100);     // at random. Step impacts the rotations and the diameters
  fullR=radians(random(360));    // determines the starting orientation at random
  
}

//------------------------------------------------ DRAW -----------------------------------------------

void draw() {
  
  num=frameCount;
  
  diam=(mouseY/2+step)%height/4;      // mouseY impacts the diameter; + step means the value is never too small, and % keeps it a reasonable size 
  mX = sin(radians(frameCount)) * (sinX);    // sin value oscillates between small values. Multiply to see actual impact
  mY=cos(radians(frameCount))*(cosX*2);      // same as above, but *2 to ensure the values differ. Could do without or have mX be the bigger one

  noFill();
  stroke(r, g, b, a);    // random colours and alpha
  strokeWeight(1);
  translate(x, y);      // everything at the center of the screen!
  rotate(fullR);        // rotation of the whole canvas at the start. Static value
  
  push();                // push() and pop() to make sure each transformation doesn't affect the one before the call push/pop
  rotate(radians(angle));    // angle increments each loop, so the rotation is animated
  push();                // new ellipse = new push/pop
  rotate(radians(angle+step));    // disalign the rotation
  translate(mX/2, mY/2);          // mX and mY oscillate between values, creates the spirograph effect
  ellipse(0, 0, diam, diam);      // first drawing circle
  push();
  rotate(radians(angle+step*2));
  translate(mX/3, mY/3);
  ellipse(0, 0, diam/3, diam/3);
  push();
  rotate(radians(angle+step*3));
  translate(mX/4, mY/4);
  ellipse(0, 0, diam/4, diam/4);
  push();
  rotate(radians(angle+step*4));
  translate(mX/5, mY/5);
  ellipse(0, 0, diam/5, diam/5);
  pop();
  pop();
  pop();
  pop();
  pop();      // don't forget to count your push and pop! 
  
  angle++;    // angle increments at the end of each loop
  
}

//----------------------------------------------- EVENTS ----------------------------------------------

void mousePressed(){    // when any mouse button is pressed, reset the random values of the colours

  a=random(3, 7);
  r=random(255);
  g=random(255);
  b=random(255);

}

void keyPressed(){      // when any key is pressed, saves an image
  
 save("sketch"+num+".png");
  
}
