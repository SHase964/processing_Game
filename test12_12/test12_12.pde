float floorHeight;
float x, y, vx, vy, ax, g;
float bgx, bgw, bvx, bvy;

void setup()
{
  size(500, 240);
  background(0);
  noStroke();
  
  //床の高さを設定
  floorHeight = 0.75*height;
  
  x = 10;
  y = floorHeight;
  vx = 0;
  vy = 0;
  ax = 0;
  g = 1;
  
  bgx = 0;
  bgw = width * 2;
  bvx = 0;
  bvy = 0;
}


void draw()
{
   background(0);
   
   
   
   //背景描写
   drawBackground(bgx);
   if (bgw > bgx+width) {
     bgx+=5;
     println("bgx:",bgx);
   }
   else{
     vx+=5;
     //println("jo");
   }
   //キャラクター描写
     drawcharacter(); 
}


void keyPressed()
{
  
}


void keyReleased()
{
  
}

void drawBackground(float backgroundX)
{
  fill(255);
  ellipse(50-backgroundX,50,16,16);
  ellipse(270-backgroundX,70,16,16);
  ellipse(320-backgroundX,50,16,16);
  ellipse(530-backgroundX,60,16,16);
  ellipse(620-backgroundX,50,16,16);
  ellipse(730-backgroundX,70,16,16);
  ellipse(800-backgroundX,50,16,16);
 
  //stroke(255, 0, 0);
  
  rect(920-backgroundX,60,2,floorHeight);
  fill(255, 0, 0);
  rect(922-backgroundX, 60, 10, 10);
  
  //床描写
  fill(255);
  rect(0, floorHeight, width, floorHeight);
}

void drawcharacter()
{
  fill(0, 191, 100);
  rect(x+vx, y-20, 20, 20);
  //println()
}
