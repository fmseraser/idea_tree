/*import java.util.LinkedList;

int mode;
int pointX, pointY;
int flagSave=0;
int flagOpen=0;
int alpha = 0;
boolean boolCtrl=false;
PFont myfont;
LinkedList<LinkedList<TextBox>> list = new LinkedList<LinkedList<TextBox>>();
Id press = new Id(-1, -1);
Id sId   = new Id(-1, -1);
FileManager fileManager = new FileManager();

void setup() {
  size(displayWidth, displayHeight);
  convert_set();
  colorMode(HSB, 360, 100, 100);
  myfont = createFont("YuGo-Bold", 48);
  textAlign(CENTER);
  textFont(myfont);
  list.add(new LinkedList<TextBox>());
}

void draw() {  
  background(#FFFFBB);
  fileManager.drawTimerText();
  if (sId.order != -1 && sId.number != -1) list.get(sId.order).get(sId.number).display();
  for (int i=0; i<list.size (); i++) {
    for (int j=0; j<list.get (i).size(); j++) {
      list.get(i).get(j).display();
    }
  }
  for (int i=0; i<list.size (); i++) {
    for (int j=0; j<list.get (i).size(); j++) {
      list.get(i).get(j).displayLine(i, j);
    }
  }
  if (mousePressed && pointX != -100 && pointY != -100) {
    if (sId.order == -1 && sId.number != -1) {
      int superX = list.get(sId.order).get(sId.number).x+list.get(sId.order).get(sId.number).width/2;
      int superY = list.get(sId.order).get(sId.number).y+list.get(sId.order).get(sId.number).height/2;
      int subX   = (pointX+mouseX)/2;
      int subY   = (pointY+mouseY)/2;
      line(superX, superY, subX, subY);
    }
    strokeWeight(4);
    noFill();
    rect(pointX, pointY, mouseX-pointX, mouseY-pointY, 20);
  }
  if (sId.order != -1 && sId.number != -1 && boolCtrl) {
    stroke(220, 10, 10, 200);
    strokeWeight(6);
    int sx=list.get(sId.order).get(sId.number).x+list.get(sId.order).get(sId.number).width/2;
    int sy=list.get(sId.order).get(sId.number).y+list.get(sId.order).get(sId.number).height/2;
    float len=dist(sx, sy, mouseX, mouseY)/6;
    float rad=atan2(mouseY-sy, mouseX-sx);
    line(sx, sy, mouseX, mouseY);
    line(mouseX, mouseY, mouseX-len*cos(rad+PI/6), mouseY-len*sin(rad+PI/6));
    line(mouseX, mouseY, mouseX-len*cos(rad-PI/6), mouseY-len*sin(rad-PI/6));
  }
  alpha = (alpha <= 0 ? 0 : alpha-1);
}*/