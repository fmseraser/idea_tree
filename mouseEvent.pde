void mousePressed() {
  //亀田 mapFlagがtrueの時は座標変更だけを受け付ける
  if (mapFlag) {
    map.pressed();
  } else {
    if (mouseButton == RIGHT) {
      sId = new Id(-1, -1);
    } else {
      mode = 0;
    label:
      for (int i = 0; i < list.size (); i++) {
        for (int j = 0; j < list.get (i).size(); j++) {
          if (list.get(i).get(j).bounds() || list.get(i).get(j).round()) {
            mode = 1;
            break label;
          }
        }
      }
      boolean grip_flag = false;
      for (int i = 0; i < list.size (); i++) {
        for (int j = 0; j < list.get (i).size(); j++) {
          if (list.get(i).get(j).round() && !grip_flag) {
            list.get(i).get(j).grip = 0;
            grip_flag = true;
          } else if (list.get(i).get(j).boxPressed() && !grip_flag) {
            list.get(i).get(j).grip = 1;
            grip_flag = true;
          } else {
            list.get(i).get(j).grip = -1;
          }
          list.get(i).get(j).proundPressed = list.get(i).get(j).round();
        }
      }
      press = pressedBox();
      switch(mode) {
      case 0://アイテム作成
        pointX = changedMouseX;
        pointY = changedMouseY;
        break;
      case 1://アイテム選択
        boolean flag = true;
        for (int i = 0; i < list.size (); i++) {
          for (int j = 0; j < list.get (i).size(); j++) {
            if (list.get(i).get(j).boxPressed()) {
              if (!boolCtrl) sId = new Id(i, j);//changed by moriguchi
              else if (sId.order != -1 && sId.number != -1) {
                boolean _flag = true;
                for (int k = 0; k < list.get (sId.order).get(sId.number).idList.size(); k++) {
                  if (list.get(sId.order).get(sId.number).idList.get(k).order == i && list.get(sId.order).get(sId.number).idList.get(k).number == j) _flag=false;
                }
                if (_flag) list.get(sId.order).get(sId.number).idList.add(new Id(i, j));
              }
              flag = false;
            }
          }
        }
        if (flag) sId = new Id(-1, -1);
        break;
      }
    }
  }
}

void mouseReleased() {
  if (mapFlag) {
    map.released();
  } else {
    switch(mode) {
    case 0://アイテム作成
      if (pointX == -100 && pointY == -100) return;
      if (sId.order != -1 && sId.number != -1) {
        list.add(new LinkedList<TextBox>());
        list.get(sId.order+1).add(new TextBox(pointX, pointY, (changedMouseX-pointX >= 0 ? (changedMouseX-pointX > 90 ? changedMouseX-pointX : 90) : (changedMouseX-pointX < -90 ? changedMouseX-pointX : -90)), (changedMouseY-pointY >= 0 ? (changedMouseY-pointY > 60 ? changedMouseY-pointY : 60) : (changedMouseY-pointY < -60 ? changedMouseY-pointY : -60)), list.get(sId.order).get(sId.number).h+7, int(list.get(sId.order).get(sId.number).s-5), int(list.get(sId.order).get(sId.number).b-5), sId.order, sId.number));
      } else {
        list.get(0).add(new TextBox(pointX, pointY, (changedMouseX-pointX >= 0 ? (changedMouseX-pointX > 90 ? changedMouseX-pointX : 90) : (changedMouseX-pointX < -90 ? changedMouseX-pointX : -90)), (changedMouseY-pointY >= 0 ? (changedMouseY-pointY > 60 ? changedMouseY-pointY : 60) : (changedMouseY-pointY < -60 ? changedMouseY-pointY : -60)), (70*list.get(0).size()+230)%360, 100, 100, -1, -1));
      }
      pointX = -100;
      pointY = -100;
      break;
    case 1://アイテム選択
      break;
    }
    for (int i = 0; i < list.size (); i++) {
      for (int j = 0; j < list.get (i).size(); j++) {
        list.get(i).get(j).proundPressed = false;
      }
    }
  }
}

//亀田 マウスホイールで拡大縮小 トラックパッドではおそらく二本指の上下スワイプ
//WindowsとMacでは上下移動方向が逆であるらしいので要検討
void mouseWheel(MouseEvent e) {
  map.wheel(e);
}