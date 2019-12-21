int i,j, maxB;
final int nomalV = 1;
boolean fallFlag;
boolean gameoverFlag;
int pushtimes;
int outbreak;
int sizex, sizey;
float floorHeight;
float x, y, vx, vy, ax, g, prey;
float bgx, bgw, bvx, bvy;
float topx;  //キャラクターの先端のx座標

class Block{
  float x, y, tx, ty, lastx;
 
  public Block(float x, float y, float tx, float ty) {
    this.x = x;
    this.y = y;
    this.tx = tx;
    this.ty = ty;
    this.lastx = x+tx;
  }
}

Block b[] = new Block [30];
drawing d;

void setup()
{
  size(1000,500);
  background(0);
  noStroke();
  frameRate(360);
  
  bgx = 0;
  bgw = width * 2;
  bvx = 0;
  bvy = 0;
  
  //床の高さを設定
  floorHeight = 0.75*height;
  pushtimes = 0;
  x = width*0.05;  //キャラの画面左の余間
  y = floorHeight;
  vx = 0;
  vy = 0;
  ax = 0;
  g = 0.03;
  topx = x+20;
  outbreak = 0;
  
  //地面設計
  b[0] = new Block(0, floorHeight, 400,height);
  b[1] = new Block(b[0].lastx+200, floorHeight-50, 600,height);
  b[2] = new Block(b[1].lastx+100, floorHeight-100, 1000, height);
  
  //今キャラクター下にいるブロック
  i = 0;
  j = 0;
  maxB = 2;
  fallFlag = false;
  gameoverFlag = true;
  
  d = new drawing();
 
  ((java.awt.Canvas) surface.getNative()).requestFocus();
}


void draw()
{
  float fps;
  fps = frameRate;
  maingame();

}


void keyPressed()
{
  switch(key) {
    case 'w':
      if (y <= floorHeight && pushtimes == 0) {
        vy = -2.5;
        pushtimes = 1;
      }
      else if (pushtimes == 1 ){
        pushtimes = 2;
        if (vy <= 0) vy -= 2;
        else         vy -= 4;
      }
      break;
  }
}


void maingame(){
  
  //println("y:",y, "b[i].y", b[i].y, "floorHeight", floorHeight);
   background(0);
   //背景描写
   d.drawBackground(bgx);
   //キャラクター描写
   d.drawcharacter(); 
   //地面描写
   d.drawground(bgx);
   
   //GAMEOVER
   if (topx == b[i].x && y > b[i].y || y == height+20) {
     //println("topx,",topx,"b[i].x", b[i].x);
     println("GAMEOVER");
     gameoverFlag = false;
   }
       
   if (gameoverFlag)
     gamelogic();
}

void gamelogic()
{
   topx+=nomalV;
      
   //キャラクタージャンプ及び落下
   vy += g;
   y += vy;
   if (y > floorHeight) {
     vy = 0;
     y = floorHeight;
     pushtimes = 0;
   }  
   //流れる処理
     if (bgw > bgx+width) {
       bgx+=nomalV;
     }  
     else{
       vx+=nomalV;
     }
   
   //new更新
   if (b[i].lastx <= topx && i < maxB) i++;
   //floor
   if (topx < b[i].x) {
     floorHeight = height+20;
     fallFlag = true;
  }   
   else{
     floorHeight = b[i].y;
   }
   
     
}
