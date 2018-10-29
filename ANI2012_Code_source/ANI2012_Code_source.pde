// ANI2012A18_TP1_E01.pde - Brochu William, Carignan Hélène, Harvey Eric, Verneuil Emma, et Valiquette Sandie

// Attention pour lire le code, vous avez besoin de télécharger la librairie Minim (cela permet de lire les sons)
// (par le menu Tool -> Add Tool... -> Onglet 'Librairies')

// Attention pour lire le code, vous avez besoin de télécharger la librairie GStreamer-based (pour lire le vidéo)
// (par le menu Tool -> Add Tool...-> Onglet 'Librairies)

//---------------------------------------
//VARIABLES Interface de base 
//(textes, boutons (music ON/OFF et restart) et autres sons déclenchés auto)
PFont typo1; 
PFont typoD; // Police utilisee pour le drum
PFont typo3; // et il y a typo2 dans la classe StartButton

PImage imgON; //Image musique de fond ON
PImage imgOFF; //Image musique de fond OFF

import ddf.minim.spi.*; // Déclaration des sons
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import ddf.minim.*;
import processing.video.*; // pour la vidéo

Minim minim;
AudioPlayer trame_sonore; // Son de la trame de fond
AudioPlayer bulle_ouverte; // Son pour l'ouverture des bulles (pop)
AudioPlayer bulle_fermee; // Son pour la fermeture des bulles (pop)
AudioPlayer feuArtifice;  //Son si bulle feux agrandie
AudioPlayer soundOverMusicOnOff;

Minim minim2;//Déclaration des sons pour le virtual drum
AudioPlayer song1;
AudioPlayer song2;
AudioPlayer song3;
AudioPlayer song4;
AudioPlayer song5;
AudioPlayer song6;
AudioPlayer song7;
AudioPlayer song8;

boolean MusicOn = true;  //flags pour bouton ON/OFF 
boolean MouseOverMusic = false;

// Variables du texte animé (description de "Processing")
int startX = 950;
int posX = startX;
int acceleration = 3;

Button restartbutton; // bouton Restart

//---------------------------------------
//VARIABLES Bulle 1 (fractal tree)
float theta; 

//---------------------------------------
//VARIABLES Bulle 2 (video)
Movie myMovie;

//---------------------------------------
//VARIABLES Bulle 3 (drum)
boolean isKeyPressedH = false; // Hi-hat
boolean isKeyPressedS = false; // Snare
boolean isKeyPressedF = false; // Floor Tom
boolean isKeyPressedB = false; // Bass drum
boolean isKeyPressedC = false; // Crash
boolean isKeyPressedR = false; // Ride
boolean isKeyPressed1 = false; // Tom1
boolean isKeyPressed2 = false; // Tom2

//---------------------------------------
//VARIABLES Bulle 4 (GIF)
String filePrefix = "data/Images/GIF";
String fileExtension = ".jpg";
int animationFrameCount = 10;
PImage[] animation;
String fileName;
int keyframe;

//---------------------------------------
//VARIABLES Bulle 5 (particules system)
ArrayList<Firework> fireworks;

Bubble b1; //Bulle contenant l'arbre fractal
Bubble b2; //Bulle contenant le vidéo
Bubble b3; //Bulle contenant le Virtual Drum
Bubble b4; //Bulle contenant le GIF
Bubble b5; //Bulle contenant le Fireworks


void setup(){
  size(950, 680); // Taille du plan de travail
  background (#FFFFFF); //background init
  fireworks = new ArrayList<Firework>();  //Fireworks
  
  //---------------------------------------
  //Création de l'interface de base
  typo1 = loadFont ("data/Polices/cafbrewery-48.vlw");  //même texte pour le bouton "on/off" (plus petit que 48 inclus)
  typo3 = loadFont ("data/Polices/Offerings-30.vlw");
  
  //Musique du bouton "on/off"
  minim = new Minim(this);
  trame_sonore = minim.loadFile("data/Sons/Unknown_Longing.wav", 2048);
  
  if (MusicOn)
    trame_sonore.loop();
   
  // Déclaration des autres sons
  bulle_fermee = minim.loadFile("data/Sons/bulle_fermee.wav", 2018); 
  bulle_ouverte = minim.loadFile("data/Sons/bulle_ouverte.wav", 2048); 
  feuArtifice = minim.loadFile("data/Sons/feuartifice.wav", 2048);
  soundOverMusicOnOff = minim.loadFile("data/Sons/bongo_1.wav", 2048);
  
  //Bouton on/off
  imgON = loadImage("data/Images/music_ON.png"); //Image musique de fond ON
  imgOFF = loadImage("data/Images/music_OFF.png"); //Image musique de fond OFF
  
  restartbutton = new Button(380, 550, 200, 35, "Restart", 58, 99, 111);  //derniers params = RGB couleur du bouton
  
  //---------------------------------------
  //Création du drum
  minim2 = new Minim(this);
  song1 = minim2.loadFile("data/Sons/hihat.wav");
  song2 = minim2.loadFile("data/Sons/crash.wav");
  song3 = minim2.loadFile("data/Sons/tom1.wav");
  song4 = minim2.loadFile("data/Sons/tom2.wav");
  song5 = minim2.loadFile("data/Sons/snare.wav");
  song6 = minim2.loadFile("data/Sons/ride.wav");
  song7 = minim2.loadFile("data/Sons/floortom.wav");
  song8 = minim2.loadFile("data/Sons/bassdrum.wav");  
  
  typoD = loadFont ("data/Polices/Cracked-20.vlw"); //font du drum
  
  //--------------------------------------- 
  // Création de la video
  myMovie = new Movie(this, "Video.mp4"); 
  myMovie.loop(); //joue en boucle si on fait rien
  myMovie.volume(0);
  
  //---------------------------------------
  // Création du GIF
  animation = new PImage[animationFrameCount];

  for (keyframe = 1; keyframe <= animationFrameCount; ++keyframe)
  {
      // construire le nom du fichier en fonction du keyframe
      fileName = filePrefix + nf(keyframe, 2) + fileExtension;
  
      // importer l'image qui correspond au nom de fichier
      animation[keyframe - 1] = loadImage(fileName);
  }
  keyframe = 0;
  
  //---------------------------------------
  //Création et init. des bulles (x, y, rayon)
  b1 = new Bubble(250, 250, 150/2, BUBBLE_TREE);
  b2 = new Bubble(475, 150, 125/2, BUBBLE_VIDEO);
  b3 = new Bubble(690, 210, 190/2, BUBBLE_VIRTUAL_DRUM);
  b4 = new Bubble(330, 460, 140/2, BUBBLE_GIF);
  b5 = new Bubble(650, 450, 150/2, BUBBLE_FIREWORK);
}

void draw()
{
  background (#FFFFFF); //background blanc
  
  //---------------------------------------
  //Affichage de l'interface de base 
  if (MouseOverMusic)
  {
    tint(255, 200);  // Apply transparency without changing color
    image(MusicOn? imgON : imgOFF, 19, 17);
    noTint();  // Disable tint
  }
  else
  {
    image(MusicOn? imgON : imgOFF, 20,20);
  }

  //Premier texte, sans animation
  textFont(typo1, 50);
  fill(#3D3F40);
  text("Processing  Basics", 300, 360);
  
  //Deuxième texte avec lien URL
  textFont(typo3, 20);
  fill(#3A636F);
  text("Processing",20,660);
  
  //Troisième texte avec animation de la droite vers la gauche
  textFont(typo3, 20); 
  fill(#3D3F40);
  
  if (posX > 107)
    posX = posX - acceleration;
      
  text("a popular tool to learn how to code and simulate ideas quickly within the context of visual arts and technology", posX,660);
  
  restartbutton.render();   //bouton restart 
  
  //---------------------------------------
  //Affichage - Bulles
  b1.render();
  b2.render();
  b3.render();
  b4.render();  
  b5.render();
  
  //---------------------------------------
  //Affichage - Contenu - Bulles
  if (b1.State != BUBBLE_STATE_FINISHED)
    drawTree(); //b1
  
  if (b2.State != BUBBLE_STATE_FINISHED)
    drawmovie(myMovie); //b2 
    
  if (b3.State != BUBBLE_STATE_FINISHED)
    drawDrum(); //b3
    
  if (b4.State != BUBBLE_STATE_FINISHED)
    drawGIF(); //b4
  
  if (b5.State != BUBBLE_STATE_FINISHED)
    drawFireworks(); //b5  //<>// //<>// //<>//
}


//---------------------------------------
void drawTree() // CODE SPÉCIFIQUE - Fractal tree (bulle 1)
{
  stroke(255);
  strokeWeight(2); //new
  
  // Angle de 0 à 90 degrés basé sur la position de la souris
  float a = (mouseX / (float) width) * 90f;
  
  if (mouseX == 0)
    a = 45.0f; //Angle de départ
  
  theta = radians(a); // Convertir en radians
  
  if (b1.State != BUBBLE_STATE_ZOOMED)
  {
    // Dessiner l'arbre au centre de la bulle
    translate(b1.x, b1.y + b1.r/2);
    line(0,0,0,-30); // Dessiner une ligne 30 pixels
    translate(0,-30); // Déplacer à la fin de la ligne
    branch(30); // Démarer "recursive branching"
    translate(-b1.x,-b1.y - b1.r/2 + 30); //Replacer le point d'origine comme il était avant l'arbre
  }
  else
  { 
    // Même chose mais dessin 2 fois plus gros (lorsque la bulle fait un zoom)
    translate(b1.x, b1.y + b1.r);
    line(0,0,0,-60); 
    translate(0,-60); 
    branch(60);
    translate(-b1.x, -b1.y - b1.r + 60); 
  }
}

void branch(float h) // CODE SPÉCIFIQUE - Fractal tree (bulle 1)
{
  h *= 0.66;  // Each branch will be 2/3rds the size of the previous one
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();       // Save the current state of transformation (i.e. where are we now)
    rotate(theta);      // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h);   // Move to the end of the branch
    branch(h);          // Ok, now call myself to draw two new branches!!
    popMatrix();        // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

//---------------------------------------
void drawmovie(Movie myMovie) // CODE SPÉCIFIQUE - Vidéo (bulle 2)
{
  b2.render();
  
  if (b2.State == BUBBLE_STATE_ZOOMED)
  {
    image (myMovie, b2.x - 100, b2.y - 120/2, 200, 120);
    myMovie.volume(1.0); // Encore une fois test avec le volume qui part au bon moment.. mais ça plante..
  }
  else
  {
    tint(255, 200);  // Apply transparency without changing color
    image (myMovie, b2.x - 50, b2.y - 60/2, 100, 60);
    noTint();  // Disable tint
  }
}

//---------------------------------------
//void drawDrum() //CODE SPECIFIQUE - DRUM (bulle 3) - fnc dans drawDrum

//---------------------------------------
void drawGIF() // CODE SPÉCIFIQUE - Séquence d'images Gif (bulle 4)
{
  // déterminer le keyframe courant
    keyframe = frameCount/60 % animationFrameCount;
        
    b4.render(); //force un refresh (couleur de la bulle) avant le dessin de l'image pour ne pas voir la transition
        
    if (b4.State == BUBBLE_STATE_ZOOMED)
      image(animation[keyframe], b4.x - 85, b4.y - 95, 175, 175);
    else if (b4.State == BUBBLE_STATE_MOUSEOVER)
    {
      tint(255, 200);  // Apply transparency without changing color
      image(animation[keyframe], b4.x - 47, b4.y - 47, 95, 95);  
      noTint();  // Disable tint
    } 
    else
      image(animation[keyframe], b4.x - 47, b4.y - 47, 95, 95);
}


//---------------------------------------
void drawFireworks() // CODE SPÉCIFIQUE - Fireworks (bulle 5)
{
  colorMode(HSB); 
  
  if (random(1) < 0.08) {                                       //ici on peut modifier le nb de fireworks
    fireworks.add(new Firework(b5.x, b5.y, b5.State));  //Nouveau paramètre état de la bulle (clic, mouse over ou rien)
  }
   
  //Ici, on peut modifier la facon dont les feux sont lancés : ex mouse click, move ect.
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();  //maj et affiche les particules
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
  colorMode(RGB);  //replace le mode en rgb à après le dessin des feux
}  

//---------------------------------------
//fonction appelée quand un nouveau frame du vidéo est prêt à être lu
void movieEvent(Movie movie)
{
  movie.read();
}

//---------------------------------------
// fonctions pour capturer la souris
void mousePressed()
{
   //Restart maintenant vérifié sur mousePressed (moins de grichage que ds le draw on dirait...)
   if (restartbutton.isClicked()) // Redémarre le projet (bulles et animations)
   {
     posX = startX; //reset la position du texte animé
     frameCount = 0; //reset le nombre de frames affichés depuis le début à zéro pour que le gif reparte à zéro
     minim.stop(); //arrêter la musique en cours sinon pls partent  
     myMovie.stop(); //arrêter le video aussi
     setup();
   }
   
  //Verif. s'il s'agit du bouton ON/OFF
  if (mouseX>20 && mouseX<imgON.width+20 && mouseY>20 && mouseY<imgON.height+20) //(20, 20) = position du bouton 
  {
    MusicOn = !MusicOn;
    
    if (MusicOn)
      trame_sonore.play(); 
    else
      trame_sonore.pause();
  }  //<>//
  
  if (mouseX>20 && mouseX<120 && mouseY>645 && mouseY<660) //lien URL sur mousePressed (mot processing)
    link ("https://processing.org"); 
    
  //Et finalement les bulles  
  b1.clicked(mouseX, mouseY);
  b2.clicked(mouseX, mouseY);
  b3.clicked(mouseX, mouseY);
  b4.clicked(mouseX, mouseY);
  b5.clicked(mouseX, mouseY);
}

  void mouseMoved()
{ 
  //Verif. s'il s'agit du bouton ON/OFF
  if (mouseX>20 && mouseX<imgON.width+20 && mouseY>20 && mouseY<imgON.height+20) //(20, 20) = position du bouton
  {
    if (!MouseOverMusic)
      MouseOverMusic = true;
  }
  else
    if (MouseOverMusic)
    {
      soundOverMusicOnOff.rewind();
      soundOverMusicOnOff.play();
      MouseOverMusic = false;
    }
     
  restartbutton.isMouseOver();  //verif. si la souris est au-dessus du Restart
  
  b1.mouseOver(mouseX, mouseY); //ou au dessus des bulles
  b2.mouseOver(mouseX, mouseY);  
  b3.mouseOver(mouseX, mouseY);  
  b4.mouseOver(mouseX, mouseY);  
  b5.mouseOver(mouseX, mouseY);  
}

// Fonction de keyPressed pour jouer le son de chacun des éléments du virtual drum (cette fonction doit rester la dernière, pour rester en concordance avec le virtual drum et ses différents scale)
void keyPressed() 
{ if (key == 'H'||key == 'h')
  {
  song1.rewind();
  song1.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(634,210,40,40);
  }
  if (key == 'C'||key == 'c') 
  {
  song2.rewind();
  song2.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(653,183,43,43);
  }
  if (key == '1') 
  {
  song3.rewind();
  song3.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(669,210,23,23);
  }
  if (key == '2')
  {
  song4.rewind();
  song4.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(700,210,30,30);  
  }
  if (key == 'S'||key == 's')
  {
  song5.rewind();
  song5.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(670,245,38,38);
  }
  if (key == 'R'||key == 'r')
  {
  song6.rewind();
  song6.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(740,200,45,45);
  }    
  if (key == 'F'||key == 'f')
  {
  song7.rewind();
  song7.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  ellipse(740,245,42,42); 
  }
  if (key == 'B'||key == 'b')
  {
  song8.rewind();
  song8.play();
  fill (#ED2946); // Remplissage de la partie du drum jouée en rouge
  rect (700,237,9,15,3);
  }
 }
 
