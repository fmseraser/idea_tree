void deleteOneNode() {
  if (sId.order != -1 && sId.number != -1) {
    for (int i = 0; i < list.size (); i++) {
      for (int j = 0; j < list.get (i).size(); j++) {
        for (int k = 0; k < list.get (i).get(j).idList.size(); k++) {
          if (list.get(i).get(j).idList.get(k).order == sId.order) {
            if (list.get(i).get(j).idList.get(k).number == sId.number) {
              list.get(i).get(j).idList.get(k).order  = list.get(sId.order).get(sId.number).idList.get(0).order;
              list.get(i).get(j).idList.get(k).number = list.get(sId.order).get(sId.number).idList.get(0).number;
              break;
            } else if (list.get(i).get(j).idList.get(k).number >= sId.number)
              list.get(i).get(j).idList.get(k).number -= 1;
          }
        }
      }
    }
    list.get(sId.order).remove(sId.number);
    sId.number -= 1;
    if (sId.number == -1 && sId.order > 0) {
      sId.order -= 1;
      sId.number = list.get(sId.order).size()-1;
    }
  }
}

Id pressedBox() {
  for (int i = 0; i < list.size (); i++) {
    for (int j = 0; j < list.get (i).size(); j++) {
      if (list.get(i).get(j).round() || list.get(i).get(j).bounds()) {
        return (new Id(i, j));
      }
    }
  }
  return (new Id(-1, -1));
}