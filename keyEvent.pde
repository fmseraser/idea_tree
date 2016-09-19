void keyPressed() {
  switch(key) {
  case 's':
    if (flagSave == 0) flagSave=1;
    break;
  case 'o':
    if (flagOpen == 0) flagOpen=1;
    break;
  }
  switch(keyCode) {
  case CONTROL:
    boolCtrl=true;
    break;
  }
  if (!boolCtrl) {
    switch(keyCode) {
    case DELETE:
      deleteOneNode();
      break;
    case 8:
      if (list.get(sId.order).get(sId.number).text.size() > 0) {
        if (list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index-1 >= 0)
          list.get(sId.order).get(sId.number).text.remove(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index-1);
      }
      break;
    case 10:
      if (sId.order != -1 && sId.number != -1) {
        if (list.get(sId.order).get(sId.number).text.size() > 0 && list.get(sId.order).get(sId.number).t.get(list.get(sId.order).get(sId.number).t.size()-1).equals("\n")) {
          list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, " ");
        } else if (list.get(sId.order).get(sId.number).homePos()) {
          list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, " ");
        }
        if (list.get(sId.order).get(sId.number).text.size() == 0) list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, " ");
        list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, "\n");
      }
      break;
    case 35: // End
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).index = list.get(sId.order).get(sId.number).getIndex(list.get(sId.order).get(sId.number).currentLine()) + 1;
      }
      break;
    case 36: // Home
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).index = list.get(sId.order).get(sId.number).getIndex(list.get(sId.order).get(sId.number).currentLine()-1) + 1;
      }
      break;
    case UP:
      if (sId.order != -1 && sId.number != -1) {
        if (list.get(sId.order).get(sId.number).currentLine() > 1) {
          int head = list.get(sId.order).get(sId.number).lineHomeIndex(list.get(sId.order).get(sId.number).currentLine()-1);
          int len  = list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()-1);
          int gap  = list.get(sId.order).get(sId.number).centerGap();
          if (list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()) > list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()-1)) {
            if (ceil(list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()-1)/2.0) < abs(gap)) {
              if (gap < 0) {
                list.get(sId.order).get(sId.number).index = head + 1;
              } else {
                list.get(sId.order).get(sId.number).index = head - len + 1;
              }
            } else {
              list.get(sId.order).get(sId.number).index = head - len/2 - gap;
              println(list.get(sId.order).get(sId.number).index);
            }
          } else {
            list.get(sId.order).get(sId.number).index = head - len/2 - gap + 1;
          }
        }
      }
      break;
    case DOWN:
      if (sId.order != -1 && sId.number != -1) {
        if (list.get(sId.order).get(sId.number).currentLine() < list.get(sId.order).get(sId.number).countLine()) {
          int head = list.get(sId.order).get(sId.number).lineHomeIndex(list.get(sId.order).get(sId.number).currentLine()+1);
          int len  = list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()+1);
          int gap  = list.get(sId.order).get(sId.number).centerGap();
          if (list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()) > list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()+1)) {
            if (ceil(list.get(sId.order).get(sId.number).lineLength(list.get(sId.order).get(sId.number).currentLine()+1)/2.0) <= abs(gap)) {
              if (gap < 0) {
                list.get(sId.order).get(sId.number).index = head  + 1;
                println("d");
              } else {
                list.get(sId.order).get(sId.number).index = head - len + 1;
                println("c");
              }
            } else {
              list.get(sId.order).get(sId.number).index = head - len/2 - gap + 1;
              println("a");
            }
          } else {
            list.get(sId.order).get(sId.number).index = head - len/2 - gap + 1;
            println("b");
          }
        }
      }
      break;
    case LEFT:
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).index++;
        if (list.get(sId.order).get(sId.number).index > list.get(sId.order).get(sId.number).text.size()) {
          list.get(sId.order).get(sId.number).index = list.get(sId.order).get(sId.number).text.size();
        }
      }
      break;
    case RIGHT:
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).index--;
        if (list.get(sId.order).get(sId.number).index < 0) {
          list.get(sId.order).get(sId.number).index = 0;
        }
      }
      break;
    case 45:
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, "ー");
      }
      break;

    case ALT:  //亀田
      mapFlag = true;
      break;

    default:
      if (sId.order != -1 && sId.number != -1) {
        list.get(sId.order).get(sId.number).t.add(list.get(sId.order).get(sId.number).text.size()-list.get(sId.order).get(sId.number).index, "" + key + "");
      }
      break;
    }
  } else {
    if (flagSave == 1) {
      flagSave = -1;
      fileManager.saveNodesFile(list, "nodes.txt");
    }
    if (flagOpen == 1) {
      flagOpen = -1;
      list = fileManager.openNodesFile("nodes.txt");
    }
  }
}

void keyReleased() {
  switch(keyCode) {
  case CONTROL:
    boolCtrl = false;
    break;

  case ALT:  //亀田
    mapFlag = false;
    break;
  }
  switch(key) {
  case 's':
    flagSave = 0;
    break;
  case 'o':
    flagOpen = 0;
    break;
  }
}