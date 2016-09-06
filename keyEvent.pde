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
        list.get(sId.order).get(sId.number).text.remove(list.get(sId.order).get(sId.number).text.size()-1);
      }
      break;
    default:
      if (sId.order != -1 && sId.number != -1)
        list.get(sId.order).get(sId.number).t.append("" + key + "");
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