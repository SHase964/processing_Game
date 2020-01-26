import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Jump_Game extends PApplet {


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
final float g = 0.03f;               //自由落下
final float acceleration = 0.00005f; //加速度
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

public void setup()
{
  
  background(0);
  noStroke();
  frameRate(360);
  textAlign(CENTER);
  FH = 0.75f*height;
  
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


public void draw()
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


public void keyPressed()
{
  switch(key) {
    case 'w':
      if (glogic == true ) {
        if (y <= floorHeight && pushtimes == 0) {
        vy = -2.5f;
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

public void Initialize()
{
  i = 0;
  pushtimes = 0;         
  x = width*0.05f;        
  vx = 0;
  vy = 0;
  topx = x+20;
  floorHeight = FH;
  y = floorHeight;
  bgx = 0;
  rad = false;           
  glogic = false; 
  gameoverFlag = false;
  nomalV = 1.5f;
  
  InitializeBlock();
}

public void InitializeBlock()
{
  B[0] = new Block(0, FH+50, 1000,height);
  for (int  k = 1; k < 10; k++) {
    B[k] = new Block(B[k-1].lastx+(int)random(100, 300), FH +(int)random(250)-200, (int)random(90, 500), height);
    if (B[k-1].y - B[k].y >= 230 && (B[k].x-B[k-1].lastx <= 150 || B[k].x-B[k-1].lastx >= 150))
      k--;
  }
}

class GameLogic{
  
  public void maingame(){
     
    //キャラクター描写
     d.drawcharacter(); 
     //地面描写
     d.drawground();
     
     //たまっころ
     if (homeback >= 1000)
      homeback = 0;
     dmenu.tama();
     if (gameoverFlag == false)
      homeback += nomalV;

     //距離
      fill(100, 150);
      rect(50, 0, 90, 50);
      
      fill(255);
      textSize(20);
      text((int)bgx/10+"m",  100 , 30); 
     //GameOver
     if (topx >= B[i].x && y > B[i].y+20 || y >= height+20) {
       dmenu.dispGameOver();
       gameoverFlag = true;
     }
     
       
     if (gameoverFlag == false)
       gamelogic();
     else
       gameoverFlag = true;
  }
  
  public void gamelogic()
  {
     topx+=nomalV;
        
     //キャラクタージャンプ及び落下
     vy += g;
     y += vy;
     if (y > floorHeight) {
       vy = 0;
       y = floorHeight;
       pushtimes = 0;
       rad = false;
     }  
     
     //流れる処理
     bgx+=nomalV;  
    
    //new更新
     if (B[i%10].lastx <= topx) i++; // 次のブロックに設定
       i %= 10;
     //floor
     if (topx < B[i].x) {
       floorHeight = height+20;
     }   
     else{
       floorHeight = B[i].y;
     }   
     
     //ブロック更新
     int l = i-1;
     if (i == 0) l = 9;
     if (B[l].lastx < bgx)
       updataBlock(l);
       
     i %= 10;

     nomalV+=acceleration;
  }
  
  public void updataBlock(int k)
  {
    //println(k);
    int l = k-1;
    if (k == 0) l = 9;
    B[k] = new Block(B[l].lastx+(int)random(100, 300), FH+(int)random(250)-200, (int)random(90, 500), height);
    
     
  }
}

class dispmenu{
  
  int hu = 255;
  boolean f = true;  
  
  public void dispGameOver(){
    disp("RESURT", true);
  }
  
  public void dispHomeGame(){
    disp("Jump Game", false);
  }
  
    
  public void disp(String str, boolean result){
    fill(90, 150);
    rect(200, 50, 600, 400); 
      
    int txtx = 500, txty = 200, txtsize = 35;
    textSize(txtsize);
    float outline = (float)(txtsize/24);
    fill(255);
    text(str, txtx-outline, txty-outline);
    text(str, txtx+outline, txty-outline);
    text(str, txtx-outline, txty+outline);
    text(str, txtx+outline, txty+outline);
    
    textSize(txtsize);
    text(str, txtx, txty);
    
    if (result){
      text((int)bgx/10+"m", txtx, 250);
    }
   
    //Please Enter Key 点滅処理
    if (f)
      hu -= 1;
    else
      hu += 1;
     
    if (hu == 0)
      f = false;
    if (hu == 255)
      f = true;
      
    textSize(20);
    fill(255, hu);
    text("Please Enter Key", txtx, 300);   
    
  }
  
  public void drawHomeback() { 
   tama();
   fill(0, 191, 100); 
   rect(x, y-20, 20, 20);
    
   fill(255);
   rect(0, floorHeight, width+600, floorHeight);
  }
  public void tama(){
    fill(255);
    ellipse(50-homeback,50,16,16);
    ellipse(270-homeback,70,16,16);
    ellipse(320-homeback,50,16,16);
    ellipse(530-homeback,60,16,16);
    ellipse(620-homeback,50,16,16);
    ellipse(730-homeback,70,16,16);
    ellipse(800-homeback,50,16,16);
    
    ellipse(1000+50-homeback,50,16,16);
    ellipse(1000+270-homeback,70,16,16);
    ellipse(1000+320-homeback,50,16,16);
    ellipse(1000+530-homeback,60,16,16);
    ellipse(1000+620-homeback,50,16,16);
    ellipse(1000+730-homeback,70,16,16);
    ellipse(1000+800-homeback,50,16,16);
    
  }
}

class drawing{
  
 public void drawground()
  {
     fill(255);
     for (int k = 0; k < 10; k++) {
       rect(B[k].x-bgx, B[k].y, B[k].tx, B[k].ty);
     } 
  }
  
   public void drawcharacter()
  {
    fill(0, 191, 100);
    if (gameoverFlag) 
      fill(255, 0, 0);
    if (rad){
      pushMatrix();
      translate(x+vx, y);
      rotate(PI/-6);
      rect(0, -20, 20, 20);
      popMatrix();
    }
    else {
    rect(x+vx, y-20, 20, 20);
    }
  }

}
  public void settings() {  size(1000,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Jump_Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
