boolean english(String s) {
  for (int i = 0; i < English.length; i++) {
    if (English[i].equals(s)) return true;
  }
  return false;
}

String [] English = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
};

LinkedList<String> translate(LinkedList<String> array) {
  String original  = merge(array);
  LinkedList<String> trans = new LinkedList<String>();
  if (original.length() == 1) {
    if (convert.get(original) != null) {
      trans.add(convert.get(original));
    } else {
      trans.add(original);
    }
    return trans;
  }
  for (int i = 0; vowel(original) != -1; i++) {
    String temp = original.substring(0, vowel(original)+1);
    trans = convert(trans, temp);
    original = original.substring(temp.length(), original.length());
  }
  for (int i = 0; i < original.length()-2; i++) {
    trans.add(original.substring(i, i+1));
  }
  try {
    if (array.get(array.size()-1).equals("n") && array.get(array.size()-2).equals("n")) {
      trans.add("ん");
    } else if (array.get(array.size()-1).equals(array.get(array.size()-2)) && english(array.get(array.size()-1))) {
      trans.add("っ");
      trans.add(original.substring(original.length()-1, original.length()));
    } else {
      trans.add(original.substring(original.length()-2, original.length()-1));
      trans.add(original.substring(original.length()-1, original.length()));
    }
  }
  catch(IndexOutOfBoundsException e) {
  }
  LinkedList<String> translation = new LinkedList<String>();
  String after = merge(trans);
  for(int i = 0; i < after.length(); i++){
    translation.add(after.substring(i, i+1));
  }
  return translation;
}

LinkedList<String> convert(LinkedList<String> array, String temp) {
  if (convert.get(temp) != null) {
    array.add(convert.get(temp));
  } else {
    String end   = "";
    int endIndex = temp.length();
    if (temp.length() > 2 && convert.get(temp.substring(temp.length()-3, temp.length())) != null) {
      end = convert.get(temp.substring(temp.length()-3, temp.length()));
      endIndex -= 3;
    } else if (convert.get(temp.substring(temp.length()-2, temp.length())) != null) {
      end = convert.get(temp.substring(temp.length()-2, temp.length()));
      endIndex -= 2;
    } else {
      end = convert.get(temp.substring(temp.length()-1, temp.length()));
      endIndex -= 1;
    }
    for (int i = 0; i < endIndex; i++) {
      if (english(temp.substring(i, i+1)) == false) {
        array.add(temp.substring(i, i+1));
      } else if (temp.substring(i, i+1).equals("n")) {
        array.add("ん");
      } else if (temp.substring(i, i+1).equals(temp.substring(i+1, i+2))) {
        array.add("っ");
      } else {
        array.add(temp.substring(i, i+1));
      }
    }
    array.add(end);
  }
  return array;
}

String merge(LinkedList<String> array) {
  String merge = "";
  for (int i = 0; i < array.size (); i++) {
    merge += array.get(i);
  }
  return merge;
}

int vowel(String text) {
  int a = text.indexOf("a");
  int i = text.indexOf("i");
  int u = text.indexOf("u");
  int e = text.indexOf("e");
  int o = text.indexOf("o");
  if (a == -1 && i == -1 && u == -1 && e == -1 && o == -1) return -1; 
  int min = (a == -1 ? 9999 : a);
  if (min > i && i != -1) min = i;
  if (min > u && u != -1) min = u;
  if (min > e && e != -1) min = e;
  if (min > o && o != -1) min = o;
  return min;
}
