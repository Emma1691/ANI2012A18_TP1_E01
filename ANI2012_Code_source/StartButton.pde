class Button
{
  PVector Pos = new PVector(0,0);
  float Width = 0;
  float Height = 0;
  color Colour;
  String Text;
  Boolean Clicked = false;
  Boolean Moved = false;
  PFont typo2;
  
  Button(int x, int y, int w, int h, String t, int r, int g, int b)
  {
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    Colour = color(r,g,b);
    Text = t;   
    typo2 = loadFont ("data/Polices/meatloaf-30.vlw");
  }
  
  void render()
  {
    strokeWeight (2);
    stroke(#3D3F40); //une teinte de noir
    
    //on dessine après avoir setté la stroke
    if (Moved && !Clicked) //bouton un peu plus grand
    {
      fill(Colour, 205);  //avec alpha du mouse over
      rect(Pos.x - 2, Pos.y - 2, Width + 4, Height + 4,7);   
      textFont (typo2, 37);
    }
    else //bouton normal
    {
      fill(Colour, 255);
      rect(Pos.x, Pos.y, Width, Height,7); 
      textFont (typo2, 35);
    }
      
    fill(#FFFFFF);
    text("Restart", 442, 575);    
  }
  
  boolean isClicked()
  {
    if(mousePressed == true && mouseButton == LEFT)    
      //les parenthèses sont nécessaires entre les vérif. en x et y sinon le bouton est mal détecté
      if((mouseX >= Pos.x && mouseX <= Pos.x+200) && (mouseY >= Pos.y && mouseY <= Pos.y+35))
        Clicked = true;
      else
        Clicked = false;      

    return Clicked;
  }
  
  boolean isMouseOver()
  {
    if(mousePressed == false)
      if((mouseX >= Pos.x && mouseX <= Pos.x+200) && (mouseY >= Pos.y && mouseY <= Pos.y+35))
        Moved = true;
      else
        Moved = false;  
        
    return Moved;
 }
}
