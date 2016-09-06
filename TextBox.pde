class TextBox {

  int x, y, width, height, h, s, b, order, number;
  int grip = -1;
  boolean proundPressed = false;
  boolean pboxPressed   = false;
  boolean pmousePressed = false;
  String Text;
  StringList t    = new StringList();
  StringList text = new StringList();
  LinkedList<Id> idList = new LinkedList<Id>();

  TextBox(int x_, int y_, int _width, int _height, int _h, int _s, int _b, int Porder_, int Pnumber_) {
    x      = x_;
    y      = y_;
    width  = _width;
    height = _height;
    h      = _h;
    s      = _s;
    b      = _b;
    idList.add(new Id(Porder_, Pnumber_));
  }

  void display() {
    if (mode == 1) {
      if (grip == 0) {
        extend();
      } else if (grip == 1) {
        move();
      }
    }
    stroke(0);
    strokeWeight(4);
    fill(h, s, b, 180);
    rect(x, y, width, height, 20);
    fill(0);
    text = translate(t);
    textSize(abs(this.width) < abs(this.height) ? abs(this.width)*0.3 : abs(this.height)*0.3);
    text(merge(text), x+this.width/2, y+this.height/2);
    t             = text;
    pmousePressed = mousePressed;
    pboxPressed   = bounds();
  }

  void move() {
    if (!proundPressed && mousePressed) {
      if (this.width > 0) {
        x += (mouseX - pmouseX) / 2;
      } else {
        x += (mouseX - pmouseX) / 2;
      }
      if (this.height > 0) {
        y += (mouseY - pmouseY) / 2;
      } else {
        y += (mouseY - pmouseY) / 2;
      }
    }
  }

  void extend() {
    if ((round() || proundPressed )&& mousePressed) {
      if (this.width > 0) {
        this.width  += (mouseX - pmouseX) * 0.67;
      } else {
        this.x  += (mouseX - pmouseX) * 0.67;
        this.width -= (mouseX - pmouseX) * 0.67;
      }
      if (this.height > 0) {
        this.height += (mouseY - pmouseY) * 0.67;
      } else {
        this.y += (mouseY - pmouseY) * 0.67;
        this.height -= (mouseY - pmouseY) * 0.67;
      }
    }
    if (abs(this.width) < 60) this.width = 60 * this.width / abs(this.width);
    if (abs(this.height) < 40) this.height = 40 * this.height / abs(this.height);
  }

  boolean round() {
    float r = dist(mouseX, mouseY, x + (this.width > 0 ? this.width : 0) - 10, y + (this.height > 0 ? this.height : 0) - 10);
    return r <= 20;
  }

  boolean bounds() {
    if (this.width > 0) {
      if (this.height > 0) {
        return (mouseX >= x && mouseX < x + this.width && mouseY >= y && mouseY < y + this.height);
      } else {
        return (mouseX >= x && mouseX < x + this.width && mouseY <= y && mouseY > y + this.height);
      }
    } else {
      if (this.height > 0) {
        return (mouseX <= x && mouseX > x + this.width && mouseY >= y && mouseY < y + this.height);
      } else {
        return (mouseX <= x && mouseX > x + this.width && mouseY <= y && mouseY > y + this.height);
      }
    }
  }

  boolean boxPressed() {
    return (mousePressed && !pmousePressed && bounds());
  }

  void displayLine(int i, int j) {
    stroke(0, 0, 0, 180);
    strokeWeight(4);
    for (int k=0; k<idList.size (); k++) {
      if (idList.get(k).order<0||idList.get(k).number<0)continue;
      if (idList.get(k).order+1>list.size())continue;
      if (idList.get(k).number+1>list.get(idList.get(k).order).size())continue;
      if (idList.get(k).order!=-1)line(x+width/2, y+height/2, list.get(idList.get(k).order).get(idList.get(k).number).x + list.get(idList.get(k).order).get(idList.get(k).number).width/2, list.get(idList.get(k).order).get(idList.get(k).number).y + list.get(idList.get(k).order).get(idList.get(k).number).height/2);
    }
  }
}