
float radius = 100;
ArrayList<Particle> pList;

void setup() {
  size(700, 700,P3D);
  pList = new ArrayList<Particle> ();
}

void draw() {
  background(0);
  for(int j=0;j<200;j++){
     pList.add(new Particle());
  }
  
  for(int i=pList.size()-1;i>=0;i--){
    Particle p = pList.get(i);
    p.Update();
    p.Display();
    
    if(p.isDead()){
      pList.remove(i);
    }
    
    
  }
}


class Particle{
  float vX,vY,vZ;
  float xPos,yPos,zPos;
  float rC,gC,bC;
  float r,theta;
  boolean isSmoke;
  float temperature,lifespan;
  
  //origin (x,z) = (width/2,-350)
  Particle(){
    r = radius*sqrt(random(1));
    theta = 2*PI*random(1);
    
    //intial position
    yPos = height/3*2;
    xPos = width/2+r*sin(theta);
    //zPos = r*cos(theta)*(-1)+(-350);
    zPos = 0;
    
    //initial velocity 
    vY = random(-20,0);
    if(xPos > 380){
      vX = random(-10,0);
    }else if(xPos < 320){
      vX = random(0,10);
    }else{
      vX = random(-10,10);
    }
    
    temperature = 100;
    lifespan = 255;
    
    rC = 255;
    gC =240;
    bC = 240;
  }
  
  //update particle with delta t = 0.1;
  void Update(){
    xPos = xPos + vX*0.1;
    yPos = yPos + vY*0.1;
    
    if(xPos > 440){
      vX = random(-30,0);
    }else if(xPos < 260){
      vX = random(0,30);
    }else{
      vX = random(-10,10);
    }
    
    if(yPos < height/3){
      isSmoke = true;
      vY = -5;
      xPos = random(330,370);
    }
    
    temperature -=3;
    lifespan -=3;
    gC -= temperature*0.1;
    bC -= temperature*0.3;
    
  }
  
  void Display(){
    if(isSmoke){
      noStroke();
      fill(245,245,245,lifespan);
      ellipse(xPos,yPos,2,2);
      
    }else {
      noStroke();
      fill(rC,gC,bC,lifespan);
      ellipse(xPos,yPos,2,2);
    }
    
  }
  
  boolean isDead(){
    if(lifespan < 0){
      return true;
    }else{
      return false;
    }
  }
  
}
