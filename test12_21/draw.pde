public class drawing{
 public void drawBackground(float backgroundX)
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
  rect(bgw*0.92-backgroundX,b[maxB].y*0.4,2,floorHeight);
  fill(255, 0, 0);
  rect(bgw*0.92-backgroundX+2, b[maxB].y*0.4, height*0.04, height*0.04);
  
  //床描写
  //fill(255);
  //rect(0, floorHeight, width+600, floorHeight);
}

public void drawground(float backx)
{
   fill(255);
   rect(b[0].x-backx, b[0].y, b[0].tx, b[0].ty);
   rect(b[1].x-backx, b[1].y, b[1].tx, b[1].ty);
   rect(b[2].x-backx, b[2].y, b[2].tx, b[2].ty);
}

public void drawcharacter()
{
  fill(0, 191, 100);
  rect(x+vx, y-20, 20, 20);
}

void updatanewBlock()
{
   
}
}
