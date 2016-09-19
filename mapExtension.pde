class mapExtension {

  //亀田 座標軸の移動、拡大縮小のクラス

  boolean preTransFlag = true; //座標軸変更前のmouseX,mouseYを設定
  float preMouseX;               //座標軸変更前のmouseX
  float preMouseY;               //座標軸変更前のmouseY
  float transX = 0;              //変更後x座標軸
  float transY = 0;              //変更後y座標軸

  float scaleX = 1;              //x倍率
  float scaleY = 1;              //y倍率

  void changeAxis() {
    if (mouseButton==LEFT) {
      transX += (transMouseX-preMouseX);
      transY += (transMouseY-preMouseY);
    }
  }

  void pressed() {
    if (preTransFlag) {
      preMouseX = mouseX-transX;
      preMouseY = mouseY-transY;
      preTransFlag = false;
    }
  }

  void released() {
    //
    transMouseX = mouseX-transX;
    transMouseY = mouseY-transY;
    preTransFlag = true;
  }

  void wheel(MouseEvent e) {
    //倍率変更
    if (e.getAmount()>0) {
      //奥に回転
      scaleX += 0.05;
      scaleY += 0.05;
    } else {
      //手前に回転
      scaleX -= 0.05;
      scaleY -= 0.05;
    }
  }
}