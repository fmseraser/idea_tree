class TextBox {

  float x, y, width, height;
  int h, s, b, order, number;
  int grip = -1;
  int index = 0;
  float Lpos = 0;
  float Rpos = 0;
  boolean pSelect       = false;
  boolean proundPressed = false;
  boolean pboxPressed   = false;
  boolean pmousePressed = false;
  String Text;
  LinkedList<String> t    = new LinkedList<String>();
  LinkedList<String> text = new LinkedList<String>();
  LinkedList<Id> idList = new LinkedList<Id>();

  TextBox(float _x, float _y, float _width, float _height, int _h, int _s, int _b, int Porder_, int Pnumber_) {
    x      = _x;
    y      = _y;
    width  = _width;
    height = _height;
    h      = _h;
    s      = _s;
    b      = _b;
    idList.add(new Id(Porder_, Pnumber_));
  }

  void display(boolean select) {
    if (!pSelect && select) this.index = 0;
    if (mode == 1) {
      //亀田 mapFlagがtrueの時 移動、拡大縮小不可能
      if (!mapFlag) {
        if (grip == 0) {
          extend();
        } else if (grip == 1) {
          move();
        }
      }
    }
    stroke(0);
    strokeWeight(4);
    fill(h, s, b, (select ? 220 : 180));
    rect(x, y, width, height, 20);
    fill(0);
    text = translate(t);
    float _h = (this.height/countLine())*0.6;
    textSize(_h > 1 ? _h : 1);
    if (this.width < maxRowWidth()) {
      _h = _h * this.width / maxRowWidth() * 0.85;
      textSize(_h > 1 ? _h : 1);
    }
    if (pow(-1, (int)millis()/500) == 1 && select) {
      setPos();
      endLine();
    }
    textLeading(_h+10);
    text(merge(text), x+this.width/2, y+this.height/2);
    t             = text;
    pmousePressed = mousePressed;
    pboxPressed   = bounds();
    pSelect       = select;
  }

  void move() {
    if (!proundPressed && mousePressed) {
      if (this.width > 0) {
        x += (changedMouseX - changedPMouseX);
      } else {
        x += (changedMouseX - changedPMouseX);
      }
      if (this.height > 0) {
        y += (changedMouseY - changedPMouseY);
      } else {
        y += (changedMouseY - changedPMouseY);
      }
    }
  }

  void extend() {
    if ((round() || proundPressed )&& mousePressed) {
      if (this.width > 0) {
        this.width  += changedMouseX - changedPMouseX;
        //this.width = changedMouseX;
      } else {
        this.x  += changedMouseX - changedPMouseX;
        this.width -= changedMouseX - changedPMouseX;
        //this.width = changedMouseX;
      }
      if (this.height > 0) {
        this.height += changedMouseY - changedPMouseY;
        //this.height = changedMouseY;
      } else {
        this.y += changedMouseY - changedPMouseY;
        this.height -= changedMouseY - changedPMouseY;
        //this.height = changedMouseY;
      }
    }
    if (abs(this.width) < 60) this.width = 60 * this.width / abs(this.width);
    if (abs(this.height) < 40) this.height = 40 * this.height / abs(this.height);
  }

  boolean round() {
    float r = dist(changedMouseX, changedMouseY, x + (this.width > 0 ? this.width : 0) - 10, y + (this.height > 0 ? this.height : 0) - 10);
    return r <= 20;
  }

  boolean bounds() {
    if (this.width > 0) {
      if (this.height > 0) {
        return (changedMouseX >= x && changedMouseX < x + this.width && changedMouseY >= y && changedMouseY < y + this.height);
      } else {
        return (changedMouseX >= x && changedMouseX < x + this.width && changedMouseY <= y && changedMouseY > y + this.height);
      }
    } else {
      if (this.height > 0) {
        return (changedMouseX <= x && changedMouseX > x + this.width && changedMouseY >= y && changedMouseY < y + this.height);
      } else {
        return (changedMouseX <= x && changedMouseX > x + this.width && changedMouseY <= y && changedMouseY > y + this.height);
      }
    }
  }

  boolean boxPressed() {
    return (mousePressed && !pmousePressed && bounds());
  }

  void displayLine() {
    stroke(0, 0, 0, 180);
    strokeWeight(3);
    for (int k=0; k<idList.size (); k++) {
      if (idList.get(k).order<0||idList.get(k).number<0)continue;
      if (idList.get(k).order+1>list.size())continue;
      if (idList.get(k).number+1>list.get(idList.get(k).order).size())continue;
      if (idList.get(k).order!=-1)line(x+width/2, y+height/2, list.get(idList.get(k).order).get(idList.get(k).number).x + list.get(idList.get(k).order).get(idList.get(k).number).width/2, list.get(idList.get(k).order).get(idList.get(k).number).y + list.get(idList.get(k).order).get(idList.get(k).number).height/2);
    }
  }

  int countLine() {
    int cnt = 1;
    for (int i = 0; i < this.text.size (); i++) {
      if (text.get(i).equals("\n")) cnt++;
    }
    return cnt;
  }

  int currentLine() {
    int cnt = 1;
    int current = text.size() - this.index;
    for (int i = 0; i < current; i++) {
      if (i >= this.text.size()) break;
      if (this.text.get(i).equals("\n")) {
        cnt++;
      }
    }
    return cnt;
  }

  int currentLinePrefix() {
    int current = this.text.size() - this.index;
    String original = merge(this.text);
    for (int i = 1; i < currentLine (); i++) {
      current -= original.indexOf("\n")+1;
      original = original.substring(original.indexOf("\n")+1);
    }
    return current;
  }

  float maxRowWidth() {
    float max = 0;
    String original = merge(this.text);
    for (; original.indexOf ("\n") != -1; ) {
      String temp = original.substring(0, original.indexOf("\n"));
      max = (textWidth(temp) > max ? textWidth(temp) : max);
      original = original.substring(original.indexOf("\n")+1);
    }
    max = (textWidth(original) > max ? textWidth(original) : max);
    return max;
  }

  float currentRowWidth() {
    int current = text.size() - this.index;
    String original = merge(this.text);
    if (original.length() == 0) return 0;
    for (int i = 0; i < this.currentLine ()-1; i++) {
      current -= original.indexOf("\n");
      current--;
      original = original.substring(original.indexOf("\n")+1);
    }
    float lineWidth = (original.indexOf("\n") != -1 ? textWidth(original.substring(0, original.indexOf("\n"))) : textWidth(original));
    return textWidth(original.substring(0, current)) - lineWidth/2;
  }

  void endLine() {
    float _x = this.Rpos + this.x + this.width/2;
    float _y = this.Lpos + this.y + this.height/2;
    strokeWeight(1);
    line(_x, _y - textAscent(), _x, _y + textDescent());
  }

  int getIndex(int line) {
    int cnt = 0;
    int el  = 1;
    for (int i = 0; el <= line; i++) {
      if (i >= this.text.size()) break;
      if (this.text.get(i).equals("\n")) el++;
      cnt++;
    }
    int _in = this.text.size() - cnt - 1;
    return _in;
  }

  void setPos() {
    float h = textAscent() + textDescent() + 10;
    if (this.countLine() % 2 == 1) {
      this.Lpos = h * (currentLine() - ceil(countLine()/2.0) + 0.37);
      this.Rpos = this.currentRowWidth();
    } else {
      this.Lpos = h * (currentLine() - this.countLine()/2 - 0.15);
      this.Rpos = this.currentRowWidth();
    }
  }

  boolean homePos() {
    int current = this.text.size() - this.index;
    return current == 0 || this.text.get(current-1).equals("\n");
  }

  String lineText(int line) {
    String original = merge(this.text);
    for (int i = 1; i < line; i++) {
      original = original.substring(original.indexOf("\n")+1);
    }
    if (original.indexOf("\n") != -1) {
      original = original.substring(0, original.indexOf("\n"));
    }
    return original;
  }

  int lineLength(int line) {
    String original = merge(this.text);
    for (int i = 1; i < line; i++) {
      original = original.substring(original.indexOf("\n")+1);
    }
    if (original.indexOf("\n") != -1) {
      original = original.substring(0, original.indexOf("\n"));
    }
    return original.length();
  }

  int centerGap() {
    return this.currentLinePrefix() - this.lineLength(this.currentLine())/2;
  }

  int lineHomeIndex(int line) {
    int prefix = 1;
    String original = merge(this.text);
    for (int i = 1; i < line; i++) {
      prefix += original.indexOf("\n")+1;
      original = original.substring(original.indexOf("\n")+1);
    }
    return text.size() - prefix;
  }
}