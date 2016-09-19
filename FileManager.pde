class FileManager {
  void saveNodesFile(LinkedList<LinkedList<TextBox>> list, String filename) {
    int count=0;
    for (int i=0; i<list.size (); i++) {
      for (int j=0; j<list.get (i).size(); j++) {
        count++;
      }
    }
    String [] data = new String[count];
    count = 0;
    for (int i = 0; i < list.size (); i++) {
      for (int j = 0; j < list.get (i).size(); j++) {
        if (count >= data.length) {
          println(data.length+","+count);
          break;
        }
        data[count] = "" + i + "," + j + "," + list.get(i).get(j).x + "," + list.get(i).get(j).y
          + "," + list.get(i).get(j).width + "," + list.get(i).get(j).height + ","
          + list.get(i).get(j).idList.size();
        for (int k = 0; k < list.get(i).get(j).idList.size(); k++) data[count] += "," + list.get(i).get(j).idList.get(k).order + "," + list.get(i).get(j).idList.get(k).number;
        for (int k = 0; k < list.get(i).get(j).t.size(); k++) data[count] += "," + list.get(i).get(j).t.get(k);
        count++;
      }
    }
    saveStrings(filename, data);//変換した文字列をテキストファイルとして出力
    println("\nsaved data.");
    setTimerText(50, 30, "\nsaved data.", 50);
  }

  LinkedList<LinkedList<TextBox>> openNodesFile(String filename) {
    LinkedList<LinkedList<TextBox>> list_ = new LinkedList<LinkedList<TextBox>>();
    String [] data;
    String [] line;
    data = loadStrings(filename);//入力ファイルを行ごとに展開する
    int order  = -1;
    int number = -1;
    for (int i = 0; i < data.length; i++) {
      line = split(data[i], ',');
      if (order != Integer.parseInt(line[0])) list_.add(new LinkedList<TextBox>());
      order  = Integer.parseInt(line[0]);
      number = Integer.parseInt(line[1]);
      // TextBoxのコンストラクタが変更になったのでセーブの形式を変えなければいけない　->　コメントアウトしておきます
      //list_.get(order).add(new TextBox(Integer.parseInt(line[2]), Integer.parseInt(line[3]), 
      //  Integer.parseInt(line[4]), Integer.parseInt(line[5]), Integer.parseInt(line[7]), Integer.parseInt(line[8])));
      int j = 1;
      for (; j < Integer.parseInt (line[6]); j++) list_.get(order).get(number).idList.add(new Id(Integer.parseInt(line[7+j*2]), Integer.parseInt(line[8+j*2])));
      for (int k = 7+j*2; k < line.length; k++) list_.get(order).get(number).t.add(line[k]);
    }
    println("\nloaded data");
    alpha = 50;
    setTimerText(50, 30, "\nloaded data", 50);
    return list_;
  }

  float tx, ty;
  String tex;
  int count;

  void setTimerText(float _tx, float _ty, String _tex, int _count) {
    tx    = _tx;
    ty    = _ty;
    tex   = _tex;
    count = _count;
  }
  void drawTimerText() {
    if (count>0) {
      count--;
      fill(0, alpha);
      textSize(50);
      text(tex, width/2, height-100);
    }
  }
}