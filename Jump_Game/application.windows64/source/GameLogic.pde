
class GameLogic{
  
  void maingame(){
     
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
  
  void updataBlock(int k)
  {
    //println(k);
    int l = k-1;
    if (k == 0) l = 9;
    B[k] = new Block(B[l].lastx+(int)random(100, 300), FH+(int)random(250)-200, (int)random(90, 500), height);
    
     
  }
}
