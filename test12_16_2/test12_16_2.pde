int pushtimes;
int sizex, sizey;
float floorHeight;
float x, y, vx, vy, ax, g;
float bgx, bgw, bvx, bvy;
//class 

void setup()
{
  size(1000,500);
  background(0);
  noStroke();
  
  bgx = 0;
  bgw = width * 2;
  bvx = 0;
  bvy = 0;
  
  //床の高さを設定
  floorHeight = 0.75*height;
  pushtimes = 0;
  x = width*0.05;
  y = floorHeight;
  vx = 0;
  vy = 0;
  ax = 0;
  g = 0.7;
  sizex = 1400;
  sizey = 500;
  

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
   //キャラクタージャンプ
   vy += g;
   y += vy;
   if (y >= floorHeight) {
      y = floorHeight;
      pushtimes = 0;
   }  
   if (y < floorHeight && pushtimes == 0) {
     pushtimes = 1;
   }
   //キャラクター描写
     drawcharacter(); 
}


void keyPressed()
{
  switch(key) {
    case 'w':
      if (y == floorHeight) {
        vy = -10;
      }
      else if (pushtimes == 1){
        vy -= 10;
        pushtimes = 2;
      }
      break;

  }
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
  
  //GOAL描写
  rect(bgw*0.92-backgroundX,height*0.4,2,floorHeight);
  fill(255, 0, 0);
  rect(bgw*0.92-backgroundX, height*0.4, height*0.04, height*0.04);
  
  //床描写
  fill(255);
  rect(0, floorHeight, width+600, floorHeight);
}

void drawcharacter()
{
  fill(0, 191, 100);
  rect(x+vx, y-20, 20, 20);
  //println()
}
