/*--------------------------------------------------------------------*/
PShape Licht1;                                                           // Assets für das Licht
PShape Licht2;
PShape Licht3;
int startCount = round(random(360));                                     //Random Start Position des Lichtes
/*-----------------GG_JonasHapp_EyeUnendlichkeit_FinalGG_JonasHapp_EyeUnendlichkeit_FinalGG_JonasHapp_EyeUnendlichkeit_Final---------------------------------------------------*/

void setup() {
  size(1080, 800, P3D);
  //noLoop();
  frameRate(2);
  Licht1 = loadShape("Licht-01.svg");                                    // Laden der Licht Shapes
  Licht2 = loadShape("Licht-02.svg");
  Licht3 = loadShape("Licht-03.svg");
}

/*--------------------------------------------------------------------*/
float noiseMax0 = 10;                                                     // Rundheit Einstellen
float strokeWeight = 10;
float strokeweightMax = 10;                                              // Stroke Weight Maximalstärke einstellen
float backgroundColor = 0;
float phase = 0;

float xoff = 0;                                                          // 
float yoff = 0;
float zoff = 0;

int seed = 20211205;                                                     // Start Seed Farbe

/*--------------------------------------------------------------------*/
void draw() {
  background(backgroundColor);
  randomSeed(seed);
  translate(width/2, height/2);

  
/*--------------------------------------------------------------------*/

float countRings = 40;                                                 //Anzahl Iris Ringe
float whiteRings = 80;                                                 //Detailreichtum Hintergrund Gradient

float rnd1 = (random(360));                                            //Farben einstellen
colorMode(RGB);
color[] colArray = {

  color(rnd1, (rnd1 + 190) % 255, (rnd1 + 190) % 255, 100),
  color(rnd1, (rnd1 + 200) % 255, (rnd1 + 200) % 255, random(60, 80)),
  color(rnd1, (rnd1 + 210) % 255, (rnd1 + 10) % 255, 100),
  color(rnd1, (rnd1 + 230) % 255, (rnd1 + 30) % 255, random(80, 100)),
  color(rnd1, (rnd1 + 250) % 255, (rnd1 + 50) % 255, 100),
};

/*--------------------------------------------------------------------*/
//Zeichnen der Sphere
  
  noFill();
  lights();
  blendMode(LIGHTEST);
  stroke(255);
  strokeWeight(0.1);
  
  float sphereRotate = random(360);
  
  pushMatrix();
  rotate(sphereRotate + (frameCount * 0.05));
  sphere(323);
  popMatrix();
  blendMode(NORMAL);


/*--------------------------------------------------------------------*/
//Weißer Hintergrund
  
  for(int k = 0; k < whiteRings; k++) { //Loop für mehr Ringe
            
          float sincol = sin(k*0.1+10);
          float mappedsincol = map(sincol, -1, 1, 0, 1);
          
          blendMode(LIGHTEST);
          
          stroke(mappedsincol*150);
          strokeWeight(5);
          ellipse(0, 0, 0 + 6 * k, 200 + 6 * k);                         // Innerer weißer Ring
          
          stroke(mappedsincol*100);                                     //Äußerer Weißer Ring *100 kann geändert werden, weißer Rand in SIN Funktion
          ellipse(0, 0, 350 + 8 * k, 100 + 8 * k);       
  }

   for(int m = 0; m < 5; m++) {
     blendMode(DARKEST);
     strokeWeight(24-4*m);
     stroke(255-50*m);
     ellipse(0, 0, width*0.95 - 5*m, height*0.95 - 5*m);
     blendMode(NORMAL);
  }
   
/*--------------------------------------------------------------------*/
// Zeichnen der IRIS Ringe

  for(int i = 0; i < countRings; i++) { //Loop für mehr Ringe
    beginShape(); // Zeichnen eines einzelnen Kreises
      for(float j = 0; j < TWO_PI; j = j + 0.1) {
        
      strokeWeight(random(strokeweightMax)); // Dicke der Linien
      stroke(colArray[int(random(4))]); // Farbe der Linien
          
      float noiseMax1 = noiseMax0 + map(noise(1), 0, 1, 0, map((noise(1)), 0, 1, 0, 10));
      float xoff = map(cos(j + phase + i), -1, 1, 0, noiseMax1);
      float yoff = map(sin(j + phase + i), -1, 1, 0, noiseMax1);
      float radius = map(noise(xoff, yoff, zoff), 0, 1, 50, height / 2 + 50);
      float x = radius * cos(j);
      float y = radius * sin(j);
      seed = seed + 1;                                             // Ändern der Farbe in Loop Animation
      vertex(x, y);
    }
    endShape(CLOSE);
    
    phase += 0.003; //Drehung des Kreises abseits von Rotate, da hier Phase des Kreises gedreht wird
    xoff += 0.01; //
    yoff += 0.01; //
    zoff += 0.01; //
  }
  
/*--------------------------------------------------------------------*/
// Zeichnen Details
   
   strokeWeight(5);
   ellipse(0, 0, 20, 40);
   noFill();
   stroke(0);
   //strokeWeight(7);
   //ellipse(0, 0, 742, 742);
   pushMatrix();
   translate(-width/2+150, -height/2 + 7, 100);
   licht();
   popMatrix();
   
   pushMatrix();
   translate(width/2 - 150, height/2 - 7, 1);
   rotate(PI);
   licht();
   popMatrix();
   

} // Klammer von DRAW

/*--------------------------------------------------------------------*/
void licht() {
  blendMode(NORMAL);
  Licht1.disableStyle();
  Licht2.disableStyle();
  Licht3.disableStyle();
            
  pushMatrix();
  //rotate(radians(startCount));
  noStroke();
  fill(255, 50);
  shape(Licht1, -0, -0);
  shape(Licht2, -0, -0);
  shape(Licht3, 0, +0);
  popMatrix();
  blendMode(NORMAL);
  

  
}

/*--------------------------------------------------------------------*/
void keyReleased() {
  if (keyCode == LEFT) {
    seed = seed - 10;
    redraw();
  }

  if (keyCode == RIGHT) {
    seed = seed + 10;
    redraw();

  }
}
