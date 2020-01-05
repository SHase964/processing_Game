class GameLogic{
  void maingame(){
 
     //背景描写
     d.drawBackground(bgx);

    //キャラクター描写
     d.drawcharacter(); 
     
     //地面描写
     d.drawground();

     //GameOver
     if (topx == b[stage][i].x && y > b[stage][i].y+20 || y == height+20) {
       //println("topx,",topx,"b[i].x", b[i].x);    //許容範囲
       dmenu.dispGameOver();
       gameoverFlag = false;
     }
     
     //GameClear
     if (topx >= bgw-200) {
      dmenu.dispGameClear();
     }
       
     if (gameoverFlag && bgx+vx <= bgw)
       gamelogic();
     else
       gameoverFlag = false;
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
       if (bgw > bgx+width) {
         bgx+=nomalV;
       }  
       else{
         vx+=nomalV;
       }
     
     //new更新
     if (b[stage][i].lastx <= topx && i < maxB[stage]) i++; // 次のブロックに設定
     //floor
     if (topx < b[stage][i].x) {
       floorHeight = height+20;
       //fallFlag = true;
    }   
     else{
       floorHeight = b[stage][i].y;
     }
    
       
  }

}
