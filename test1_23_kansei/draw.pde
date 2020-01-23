
class drawing{
  
 void drawground()
  {
     fill(255);
     for (int k = 0; k < 10; k++) {
       rect(B[k].x-bgx, B[k].y, B[k].tx, B[k].ty);
     } 
  }
  
   void drawcharacter()
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
