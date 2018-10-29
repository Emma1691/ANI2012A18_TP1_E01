//LN Nouvelle classe Bubble
// constantes globales (= visibles de partout)
final static int BUBBLE_STATE_NORMAL = 1;
final static int BUBBLE_STATE_MOUSEOVER = 2;
final static int BUBBLE_STATE_ZOOMED = 3;
final static int BUBBLE_STATE_FINISHED = 4;

final static int BUBBLE_TREE = 1;         //Bulle Arbre Fractal
final static int BUBBLE_VIDEO = 2;        //Bulle vidéo
final static int BUBBLE_VIRTUAL_DRUM = 3; //Bulle Virtual Drum
final static int BUBBLE_GIF = 4;          //Bulle GIF
final static int BUBBLE_FIREWORK = 5;     //Bulle Fireworks


class Bubble 
{  
  float x;
  float y;
  float r;
  int   Type;
  int   State;
  int   Brightness;
  float Width;
  
  Bubble(float x, float y, float r, int bt)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.Type = bt;   
    this.State = BUBBLE_STATE_NORMAL;
    this.Brightness = 0;
    this.Width = r * 2; //taille = commence à 100%
  }
    
  void clicked(int xPos, int yPos)
  {
    //calculer la distance entre le clic de souris et la bulle
    float d = dist(xPos, yPos, this.x, this.y);
    
    if (d < (this.Width/2))  //si le clic est dans le rayon de la bulle
    {
      if ((State != BUBBLE_STATE_ZOOMED) && (State != BUBBLE_STATE_FINISHED))
      {
        State = BUBBLE_STATE_ZOOMED;
        this.Brightness = 0;
        this.Width = r * 2 * 2; //taille = 200%
        bulle_ouverte.rewind();
        bulle_ouverte.play();
        
        if (this.Type == BUBBLE_FIREWORK)
        {
          feuArtifice.rewind(); //le son du feu d'artifice sur zoom
          feuArtifice.play();
        }
      }
    }
    else if ((State == BUBBLE_STATE_ZOOMED) && (State != BUBBLE_STATE_FINISHED))
    {
        State = BUBBLE_STATE_FINISHED;
        bulle_fermee.rewind(); //le pop sur fermeture d'une bulle
        bulle_fermee.play();
        
        if (this.Type == BUBBLE_FIREWORK)
          feuArtifice.pause();
          
        if (this.Type == BUBBLE_VIDEO)
         myMovie.stop();
    }
  }
  
   void mouseOver(int xPos, int yPos)
  {
    float d = dist(xPos, yPos, this.x, this.y);
    
    if ((d < (this.Width/2)) && (State != BUBBLE_STATE_ZOOMED) && (State != BUBBLE_STATE_FINISHED))
    {
      State = BUBBLE_STATE_MOUSEOVER; 
      this.Brightness = 50;
      this.Width = r * 2 * 1.05f; //taille = 105%
    }
    else if ((State != BUBBLE_STATE_ZOOMED) && (State != BUBBLE_STATE_FINISHED)) 
    {
      State = BUBBLE_STATE_NORMAL; 
      this.Width = r * 2; //taille = retourner à 100%
      this.Brightness = 0;
    }
  }
  
   void renderText()
  {
    //textFont(typo1, 18);  
    textFont(typo1, 20);
    fill(255);
    
    switch(this.Type)
    {
      case BUBBLE_TREE: 
        text("Fractal Trees", this.x - r/1.5, this.y + r*1.5);
        break;
      case BUBBLE_VIDEO: 
        text("Videos", this.x - r/2, this.y + r*1.7);
        break;
      case BUBBLE_VIRTUAL_DRUM: 
        text("Press  a  key  to  play", this.x - r/1.1, this.y - r*1.5);
        text("Hit-Hat = H    Snare = S    Crash = C", this.x - r/0.75, this.y - r*1.2);
        text("Tom 1 = 1    Tom 2 = 2    Ride = R", this.x - r/0.9, this.y - r*0.9);
        text("Floor Tom = F    Bass Drum = B", this.x - r/0.9, this.y - r*0.6);
        text("Musical  Sequence", this.x - r/1.4, this.y + r*1.5);
        break;
      case BUBBLE_GIF: 
        if (keyframe <7) // Les 6 première images sont blanches et les autres noires
          fill (0);
        else
          fill (255);
        text("Images Sequence", this.x - r - 5, this.y + r*1.5);
        break;
      case BUBBLE_FIREWORK: 
        text("Particle Systems", this.x - r/1.25, this.y + r*1.5);
        break;
    }
  }
  
  void render()
  {  
    if (this.State != BUBBLE_STATE_FINISHED)
    {
      if (this.Type == BUBBLE_GIF)  //alors on override la couleur pour pas voir le carré autour
      {
        if (keyframe < 7) //les 6 premières images sont blanches et les autres noires
          fill(255);
        else        
          fill(0);
      } 
      else    
        fill(this.Brightness);
        
      stroke(133, 133, 133);
      strokeWeight(3);
        
      ellipse(this.x, this.y, this.Width, this.Width);
      
      if (this.State == BUBBLE_STATE_ZOOMED)
        renderText();
    }
  }  //<>// //<>//
}
