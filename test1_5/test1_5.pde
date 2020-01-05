int i,j, maxB[] = new int [3];  //ブロックの最大数
int stage;                      //ステージ
final int nomalV = 1;           //速さ（定数）
//boolean fallFlag;               //
boolean gameoverFlag;           //ゲームオーバーの判定
boolean rad;                    //キャラクターの角度（飛んだらtrue）
boolean glogic;                 //gamelogic
boolean pushFlag;
int hu = 255;     //Homemenu
boolean f = true; //Homemenu
int pushtimes;
int outbreak;
int sizex, sizey;
float floorHeight;             //床の高さ（穴の場合には結構大きな値をいれる）
float x, y, vx, vy;
float bgx, bgw, bvx, bvy;
final float g = 0.03;
float topx;  //キャラクターの先端のx座標
PImage keitora; 


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

Block b[][] = new Block [3][30];
drawing d;
GameLogic GL;
dispmenu dmenu;

void setup()
{
  size(1000,500);
  background(0);
  noStroke();
  frameRate(360);
  textAlign(CENTER);
  
  keitora = loadImage("keitora.jpg");
  
  bgx = 0;
  bgw = width*8; //ステージの距離
  bvx = 0;
  bvy = 0;
  
  //床の高さを設定
  floorHeight = 0.75*height;
  pushtimes = 0;
  x = width*0.05;  //キャラの画面左の余間
  y = floorHeight;
  vx = 0;
  vy = 0;
  topx = x+20;
  outbreak = 0;
  
  //地面設計
  b[0][0]  = new Block(0, floorHeight, 400,height);
  b[0][1]  = new Block(b[0][0].lastx+200, floorHeight-50, 600,height);
  b[0][2]  = new Block(b[0][1].lastx+100, floorHeight-100, 1000, height);
  b[0][3]  = new Block(b[0][2].lastx+100, floorHeight-100, 500, height);
  b[0][4]  = new Block(b[0][3].lastx+50, floorHeight+20, 400, height);
  b[0][5]  = new Block(b[0][4].lastx+220, floorHeight-40, 600, height);
  b[0][6]  = new Block(b[0][5].lastx+40, floorHeight+200, 200, height);
  b[0][7]  = new Block(b[0][6].lastx+90, floorHeight+20, 200, height);
  b[0][8]  = new Block(b[0][7].lastx+100, floorHeight+10, 500, height);
  b[0][9]  = new Block(b[0][8].lastx+50, floorHeight-20, 400, height);
  b[0][10] = new Block(b[0][9].lastx+40, floorHeight-100, 300, height);
  b[0][11] = new Block(b[0][10].lastx+120, floorHeight-10, 600, height);
  b[0][12] = new Block(b[0][11].lastx+20, floorHeight+30,200, height);
  b[0][13] = new Block(b[0][12].lastx+90, floorHeight-120, 200, height);
  b[0][14] = new Block(b[0][13].lastx+80, floorHeight-120, 1000, height);
  b[0][15] = new Block(b[0][14].lastx+80, floorHeight-120, 1000, height);
  
  //今キャラクター下にいるブロック
  i = 0;
  j = 0;
  maxB[0] = 14;
  gameoverFlag = true; //ゲームオーバー（trueでゲーム続行）
  rad = false;     //キャラの角度
  glogic = false;  //ゲーム画面
  pushFlag = false; //ジャンプ判定
  
  d = new drawing();
  GL = new GameLogic();
  dmenu = new dispmenu();
 
  stage = 0;
  ((java.awt.Canvas) surface.getNative()).requestFocus();
}

int homeback = 0;
void draw()
{
  
  float fps;
  fps = frameRate;
  background(0);
  if (glogic == false) {
    if (homeback == 1000)
      homeback = 0;
     dmenu.drawHomeback();
     dmenu.dispHomeGame();
     homeback += 1;
    }
  
  else if (glogic)
    GL.maingame();
  println("topx:", topx, "max:", bgw);
}


void keyPressed()
{
  switch(key) {
    case 'w':
      if (glogic == true ) {
        if (y <= floorHeight && pushtimes == 0) {
         //pushFlag = true;
        vy = -2.5;
        pushtimes = 1;
        rad = true;
      }
      else if (pushtimes == 1){
        pushtimes = 2;
        if (vy <= 0) vy -= 2;
        else         vy -= 4;
      }
      break;
      }
     case ENTER:
       if (glogic == false && gameoverFlag == true) // Home から Game
          glogic = true;
       else if (glogic == true && gameoverFlag == false) {
         glogic = false;// Game(Over) から Home
         Initialize();
       }
      break;
  }
}

void Initialize()
{
  gameoverFlag = true;
  i = 0;
  pushtimes = 0;
  x = width*0.05;  //キャラの画面左の余間
  vx = 0;
  vy = 0;
  topx = x+20;
  floorHeight = 0.75*height;  //初期化
  y = floorHeight;
  bgx = 0;
  rad = false;     //キャラの角度
  glogic = false; 
}
