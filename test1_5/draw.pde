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
    rect(bgw-200-backgroundX,b[stage][maxB[stage]].y-200,2,floorHeight);
    fill(255, 0, 0);
    rect(bgw-200-backgroundX+2, b[stage][maxB[stage]].y-200, height*0.04, height*0.04);
    
    //床描写
    //fill(255);
    //rect(0, floorHeight, width+600, floorHeight);
  }
  
  public void drawground()
  {
     fill(255);
     for (int bloc = 0; bloc <= maxB[stage]; bloc++) {
       //println(" bloc:", bloc);
         rect(b[stage][bloc].x-bgx, b[stage][bloc].y, b[stage][bloc].tx, b[stage][bloc].ty);
   }
  }
  
  public void drawcharacter()
  {
    fill(0, 191, 100);
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
