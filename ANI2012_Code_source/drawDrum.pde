//Formes vectorielles utilisées : ellipse, point, rectangle, ligne, polygone et arc
void drawDrum ()
{
  // Construction du Hi-Hat
  fill (#F5D479); // Forme vectorielle
  stroke(#CBB373);
  strokeWeight(1);
  ellipse(634,210,40,40);

  fill (#987739);
  noStroke();
  ellipse(634,210,8,8);
  
  strokeWeight(2);
  stroke(#504E49);
  quad (633, 209, 634, 209, 634, 210, 633, 210);
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("H", 630,227);
  
  
  // Construction du Snare
  stroke(#504E49); // Forme vectorielle
  strokeWeight(1);
  fill (#F0E5D3); 
  ellipse(670,245,38,38);
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("S", 666,253);
  
  
  // Construction des baguettes  // Attention il manque un 5e vecteur, il faut juste que je rajoute les arcs aux baguettes
  stroke(#C4987D);
  strokeWeight(2);
  line(660,250,650,270); 
  fill(#C4987D);
  
  strokeWeight(2);
  stroke(#C4987D);
  point (660,250);

  stroke(#C4987D);
  strokeWeight(2);
  line(690,270,680,250);
  fill(#C4987D);
  
  strokeWeight(2);
  stroke(#C4987D);
  point (680,250);
  
  // Construction du Bass drum
  noStroke();
  strokeWeight(0);
  fill (#212020);
  rect (698,235,13,35,3);
  
  noStroke();
  strokeWeight(0);
  fill (#434141);
  rect (700,237,9,15,3); 
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("B", 701,267);
  
  
  // Construction du tom 1
  stroke(#504E49); // Forme vectorielle
  strokeWeight(1);
  fill (#F0E5D3); 
  ellipse(669,210,23,23);
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("1", 666,215);
    
    
  // Construction du tom 2
  stroke(#504E49); // Forme vectorielle
  strokeWeight(1);
  fill (#F0E5D3); 
  ellipse(700,210,30,30); 
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("2", 696,216);
    

  // Construction du Floor tom
  stroke(#504E49); // Forme vectorielle
  strokeWeight(1);
  fill (#F0E5D3); 
  ellipse(740,245,42,42);   
    
  textFont (typoD, 20);
  fill (#C15454);
  text ("F", 738,252);


  // Construction de la crash
  fill (#F5D479); // Forme vectorielle
  stroke(#CBB373);
  strokeWeight(1);
  ellipse(653,183,43,43);
  
  fill (#987739);
  ellipse(653,183,13,13);
  fill (#504E49);
  
  strokeWeight(3);
  stroke(#504E49);
  quad (652,182, 653, 182, 653, 183, 652, 183);
  
  textFont (typoD, 20);
  fill (#C15454);
  text ("C", 649,203);
  
  
  // Construction de la ride 
 
  fill (#F5D479); // Forme vectorielle
  stroke(#CBB373);
  strokeWeight(1);
  ellipse(740,200,45,45);
  
  fill (#987739);
  ellipse(740,200,15,15);
  
  strokeWeight(3);
  stroke(#504E49);
  quad (739,199, 741, 199, 741, 201, 739,201);

  
  textFont (typoD, 20);
  fill (#C15454);
  text ("R", 737,220);
 }
