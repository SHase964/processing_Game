
int i,j;  
float nomalV;              //速さ
boolean gameoverFlag;          //ゲームオーバーの判定
boolean rad;                   //キャラクターの角度（飛んだらtrue）
boolean glogic;                //gamelogic
boolean pushFlag;              //ジャンプ回数を決めるやつ
int pushtimes;                 //ジャンプ回数を2回までに抑える
float floorHeight;             //床の高さ（穴の場合には結構大きな値をいれる）
float FH;                      //床の基準値
float x, y, vx, vy;
float bgx;                     //x座標
final float g = 0.03;               //自由落下
final float acceleration = 0.00005; //加速度
float topx;                         //キャラクターの先端のx座標
float homeback = 0;                   //ホームメニューの背景


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

Block B[] = new Block [10];
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
  FH = 0.75*height;
  
  bgx = 0;

  //床の高さを設定
  Initialize();
  
  //地面設計
  InitializeBlock();
  pushFlag = false; //ジャンプ判定
  
  d = new drawing();
  GL = new GameLogic();
  dmenu = new dispmenu();
 
  ((java.awt.Canvas) surface.getNative()).requestFocus();
}


void draw()
{
  
  float fps;
  fps = frameRate;
  background(0);
  if (glogic == false) {
    if (homeback >= 1000)
      homeback = 0;
     dmenu.drawHomeback();
     dmenu.dispHomeGame();
     homeback += nomalV;
    }
  
  else if (glogic)
    GL.maingame();

}


void keyPressed()
{
  switch(key) {
    case 'w':
      if (glogic == true ) {
        if (y <= floorHeight && pushtimes == 0) {
        vy = -2.5;
        pushtimes = 1;
        rad = true;
      }
      else if (pushtimes == 1){
        pushtimes = 2;
        if (vy <= 0) vy -= 3;
        else         vy -= 4;
      }
      break;
      }
     case ENTER:
       if (glogic == false && gameoverFlag == false) // Home から Game
          glogic = true;
       else if (glogic == true && gameoverFlag == true) {
         glogic = false;// Game(Over) から Home
         Initialize();
       }
      break;
  }
}

void Initialize()
{
  i = 0;
  pushtimes = 0;         
  x = width*0.05;        
  vx = 0;
  vy = 0;
  topx = x+20;
  floorHeight = FH;
  y = floorHeight;
  bgx = 0;
  rad = false;           
  glogic = false; 
  gameoverFlag = false;
  nomalV = 1.2;
  
  InitializeBlock();
}

void InitializeBlock()
{
  B[0] = new Block(0, FH+50, 1000,height);
  for (int  k = 1; k < 10; k++) {
    B[k] = new Block(B[k-1].lastx+(int)random(100, 300), FH +(int)random(250)-200, (int)random(90, 500), height);
    if (B[k-1].y - B[k].y >= 230 && (B[k].x-B[k-1].lastx <= 150 || B[k].x-B[k-1].lastx >= 150))
      k--;
  }
}
