class dispmenu{
  void dispGameOver(){
    disp("GameOver");
  }
  void dispGameClear(){
    disp("GOAL");
  }
  void dispHomeGame(){
    disp("GameName");
  }
  
    
  void disp(String str){
    fill(100, 150);
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
    fill(200, 0, 0);
    text(str, txtx, txty);
   
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
  
  void drawHomeback() { 
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
    
   fill(0, 191, 100); 
   rect(x, y-20, 20, 20);
    
   fill(255);
   rect(0, floorHeight, width+600, floorHeight);
  }
}
