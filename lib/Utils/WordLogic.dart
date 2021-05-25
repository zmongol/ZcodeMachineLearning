class MWordLogic {
  static final List<String> qArray = [
    "ᡳᡪᢝ",
    "ᡬᡬᡪᢝ",
    "ᢘᡪᡫ",
    "ᡳᡪᡧ",
    "ᡬᡬᡪᡧ",
    "ᡭᡭᡧ",
    "ᢘᡪᡱᡱᡪᡧ",
    "ᢘᡪᢊᡪᡧ",
    "ᢙᡪᡱᡱᡪᡧ",
    "ᢙᡪᢊᡪᡧ",
  ];
  static final List<String> vArray = [
    'ᡬᡬᡧ',
    'ᡭᡧ',
    'ᡳ',
    'ᢘᡳ',
    'ᢙᡳ',
    'ᡬᡫ',
    'ᡫ',
    'ᡥᢚᡧ',
  ];
  static final Map<String, List<String>> teinIlgal = {'q': qArray, 'v': vArray};
  static final Map<String, String> databases = {
    "aav": "ᡥᡪᡴᡭ",
    "america": "ᡥᡪᢎᢟᢞᡬᢤᡪᡨ",
    "ch": "ᡭᡭ",
    "chi": "ᡭᡭᡫ",
    "cihola": "ᢚᡬᡪᡪᡭᢑᡧ",
    "cino": "ᢚᡬᡱᡳᡨ",
    "do": "ᢙᡳ",
    "du": "ᢙᡳ",
    "eej": "ᡥᢛᡫ",
    "eyer": "ᡬᡬᡪᢝ",
    "europe": "ᡥᢟᡭᡬᢞᡭᡶᡪᡨ",
    "eyen": "ᡬᡬᡪᡧ",
    "gowa": "ᢈᡭᡳᡨ",
    "hebei": "ᡥᢨᢟᡳᢟᡫ",
    "in": "ᡬᡬᡧ",
    "kino": "ᢤᡬᡱᡭ",
    "kod": "ᢥᡭᢙᡦ",
//            put("lasa": "ᢏᢨᡪᢔᡧ",
    "mongol": "ᢌᡭᡪᢊᡱᡱᡭᢐ",
    "no": "ᡳ",
    "on": "ᡭᡧ",
    "oo": "ᡭᡳ",
    "radio": "ᢞᡪᢙᡬᡭ",
    "sh": "ᢗ",
    "shi": "ᢗᡫ",
    "su": "ᢔᡭᡦ",
    "tatar": "ᢘᡪᢘᡪᢝ",
    "yunikod": "ᢜᡭᡬᡱᡬᢥᡭᢙᡦ",
    "zh": "ᢨ",
    "zhi": "ᢨᡫ",
    "english": "ᡥᡪᡪᢊᢊᢑᡫ",
    "england": "ᡥᡪᡪᢊᢊᢑᡫ",
    "degen": "ᢙᡪᢊᡪᡧ",
    "deng": "ᢙᢟᡪᡬᡨ",
    "dan": "ᢙᡪᡧ",
    "den": "ᢙᡪᡧ",
    "din": "ᢙᡬᡧ",
    "o": "ᡥᡭ",
    "u": "ᡥᡭᡬ",
    "i": "ᡥᡫ",
    "naima": "ᡯᡪᡬᢎᡧ",
    "dung": "ᢙᡭᡬᡪᡬᡨ",
    "don": "ᢙᡭᡧ",
    "dungsigor": "ᢙᡭᡬᡪᢊᢔᡬᡱᡱᡭᢝ",
    "agola": "ᡥᡪᡱᡱᡭᢑᡧ",
    "sig": "ᢔᡬᢇ",
    "tig": "ᢘᡬᢇ",
    "tere": "ᢘᡪᢞᡧ",
  };

  static final List<String> aArr = [
    "ᡥᡧ",
    "",
    "",
    "ᡥᡪ",
    "ᡪᡪ",
    "",
    "ᡪ",
    "ᡪᡪ",
    "",
    "ᡧ",
    "ᡪᡨ",
    "ᡨ"
  ];
  static final List<String> eArr = [
    "ᡥᡨ",
    "",
    "",
    "ᡥ",
    "ᡪᡪ",
    "",
    "ᡪ",
    "ᡪᡪ",
    "",
    "ᡪᡨ",
    "ᡧ",
    "ᡨ"
  ];
  static final List<String> iArr = [
    "ᡫ",
    "",
    "",
    "ᡥᡬ",
    "",
    "",
    "ᡬ",
    "ᡬᡬ",
    "ᡪᡬ",
    "ᡫ",
    "ᡬᡦ",
    ""
  ];
  static final List<String> oArr = [
    "ᡥᡭ",
    "ᡥᡭ",
    "",
    "ᡥᡭ",
    "",
    "",
    "ᡭ",
    "ᡪᡭ",
    "",
    "ᡳ",
    "ᡭ",
    ""
  ];
  static final List<String> uArr = [
    "ᡥᡭᡦ",
    "",
    "",
    "ᡥᡭᡬ",
    "",
    "",
    "ᡭ",
    "ᡭᡬ",
    "ᡪᡭᡬ",
    "ᡳ",
    "ᡭ",
    "ᡭᡦ"
  ];
  static final List<String> nArr = [
    "ᡯ",
    "",
    "",
    "ᡯ",
    "",
    "",
    "ᡪ",
    "ᡱ",
    "",
    "ᡧ",
    "ᡰ",
    ""
  ];
  static final List<String> bArr = [
    "ᡳ",
    "",
    "",
    "ᡳ",
    "ᡴ",
    "",
    "ᡳ",
    "ᡴ",
    "",
    "ᡲ",
    "",
    ""
  ];
  static final List<String> pArr = [
    "ᡶ",
    "",
    "",
    "ᡶ",
    "ᡷ",
    "",
    "ᡶ",
    "ᡷ",
    "",
    "ᡵ",
    "",
    ""
  ];
  static final List<String> hArr = [
    "ᡸ",
    "",
    "",
    "ᡸ",
    "ᢊ",
    "ᢋ",
    "ᡪᡪ",
    "ᢊ",
    "ᢋ",
    "ᢇ",
    "ᢇ",
    ""
  ];
  static final List<String> gArr = [
    "ᢈ",
    "",
    "ᡪᡪ",
    "ᢈ",
    "ᢊ",
    "ᢋ",
    "ᡱᡱ",
    "ᢊ",
    "ᢋ",
    "ᢇ",
    "ᢉ",
    "ᡬᡨ"
  ];
  static final List<String> mArr = [
    "ᢌ",
    "",
    "",
    "ᢌ",
    "",
    "",
    "ᢎ",
    "",
    "",
    "ᢍ",
    "",
    ""
  ];
  static final List<String> lArr = [
    "ᢏ",
    "",
    "",
    "ᢏ",
    "",
    "",
    "ᢑ",
    "",
    "",
    "ᢐ",
    "",
    ""
  ];
  static final List<String> sArr = [
    "ᢔ",
    "",
    "",
    "ᢔ",
    "",
    "",
    "ᢔ",
    "",
    "",
    "ᢓ",
    "",
    ""
  ];
  static final List<String> xArr = [
    "ᢗ",
    "",
    "",
    "ᢗ",
    "",
    "",
    "ᢗ",
    "",
    "",
    "ᢖ",
    "",
    ""
  ];
  static final List<String> tArr = [
    "ᢘ",
    "",
    "",
    "ᢘ",
    "",
    "",
    "ᢙ",
    "",
    "",
    "ᢘᡦ",
    "",
    ""
  ];
  static final List<String> dArr = [
    "ᢙ",
    "",
    "",
    "ᢘ",
    "",
    "",
    "ᡭᡪ",
    "ᢙ",
    "",
    "ᡭᡧ",
    "ᢙᡦ",
    ""
  ];
  static final List<String> cArr = [
    "ᢚ",
    "",
    "",
    "ᢚ",
    "",
    "",
    "ᢚ",
    "",
    "",
    "ᢚᡦ",
    "",
    ""
  ];
  static final List<String> jArr = [
    "ᡬ",
    "",
    "",
    "ᡬ",
    "",
    "",
    "ᢛ",
    "",
    "",
    "ᢛᡦ",
    "",
    ""
  ];
  static final List<String> yArr = [
    "ᢜ",
    "",
    "",
    "ᢜ",
    "",
    "",
    "ᢜ",
    "",
    "",
    "ᡫ",
    "",
    ""
  ];
  static final List<String> rArr = [
    "ᢞ",
    "",
    "",
    "ᢞ",
    "",
    "",
    "ᢞ",
    "",
    "",
    "ᢝ",
    "",
    ""
  ];
  static final List<String> wArr = [
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟᡦ",
    "",
    ""
  ];
  static final List<String> fArr = [
    "ᢡ",
    "",
    "",
    "ᢡ",
    "ᢢ",
    "",
    "ᢡ",
    "ᢢ",
    "",
    "ᢠ",
    "",
    ""
  ];
  static final List<String> kArr = [
    "ᢤ",
    "",
    "",
    "ᢤ",
    "ᢥ",
    "",
    "ᢤ",
    "ᢥ",
    "",
    "ᢣ",
    "",
    ""
  ];
  static final List<String> qArr = [
    "ᢚ",
    "",
    "",
    "ᢚ",
    "",
    "",
    "ᢚ",
    "",
    "",
    "ᢚᡦ",
    "",
    ""
  ];
  static final List<String> zArr = [
    "ᢧ",
    "",
    "",
    "ᢧ",
    "",
    "",
    "ᢧ",
    "",
    "",
    "ᢧᡦ",
    "",
    ""
  ];
  static final List<String> vArr = [
    "ᡥᡭ",
    "ᡥᡭ",
    "",
    "ᡥᡭ",
    "",
    "",
    "ᡭ",
    "ᡪᡭ",
    "",
    "ᡳ",
    "ᡭ",
    ""
  ];

  static final List<String> AArr = [
    "ᡥᡧ",
    "",
    "",
    "ᡪᡪ",
    "",
    "",
    "ᡪᡪ",
    "",
    "",
    "ᡧ",
    "",
    ""
  ];
  static final List<String> EArr = [
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟᡦ",
    "",
    ""
  ];
  static final List<String> IArr = [
    "ᡫ",
    "",
    "",
    "ᡥᡬ",
    "",
    "",
    "ᡬ",
    "ᡬᡬ",
    "ᡪᡬ",
    "ᡫ",
    "ᡬᡦ",
    ""
  ];
  static final List<String> OArr = [
 "ᡥᡭ", "ᡥᡭ", "", "ᡥᡭ", "", "", "ᡭ", "ᡪᡭ", "", "ᡭ", "ᡭ", ""
  ];
  static final List<String> UArr = [
    "ᡥᡭᡦ", "", "", "ᡥᡭᡬ", "", "", "ᡭᡬ", "", "", "ᡭᡦ", "", ""
  ];
  static final List<String> NArr = [
  "ᡯ", "", "", "ᡯ", "", "", "ᡱ", "ᡪ", "", "ᡧ", "ᡰ", ""
  ];
  static final List<String> BArr = [
    "ᡳ",
    "",
    "",
    "ᡳ",
    "ᡴ",
    "",
    "ᡳ",
    "ᡴ",
    "",
    "ᡲ",
    "",
    ""
  ];
  static final List<String> PArr = [
    "ᡶ",
    "",
    "",
    "ᡶ",
    "ᡷ",
    "",
    "ᡶ",
    "ᡷ",
    "",
    "ᡵ",
    "",
    ""
  ];
  static final List<String> HArr = [
    "ᡸ",
    "",
    "",
    "ᡸ",
    "ᢊ",
    "ᢋ",
    "ᡪᡪ",
    "ᢊ",
    "ᢋ",
    "ᢇ",
    "ᢇ",
    ""
  ];
  static final List<String> GArr = [
    "ᢈ",
    "",
    "ᡪᡪ",
    "ᢈ",
    "ᢊ",
    "ᢋ",
    "ᡱᡱ",
    "ᢊ",
    "ᢋ",
    "ᢇ",
    "ᢉ",
    "ᡬᡨ"
  ];
  static final List<String> MArr = [
    "ᢌ",
    "",
    "",
    "ᢌ",
    "",
    "",
    "ᢎ",
    "",
    "",
    "ᢍ",
    "",
    ""
  ];
  static final List<String> LArr = [
    "ᢏᢨ",
    "",
    "",
    "ᢏᢨ",
    "",
    "",
    "ᢑᢨ",
    "",
    "",
    "ᢑᢨᡦ",
    "",
    ""
  ];
  static final List<String> SArr = [
    "ᢔ",
    "",
    "",
    "ᢔ",
    "",
    "",
    "ᢔ",
    "",
    "",
    "ᢓ",
    "",
    ""
  ];
  static final List<String> XArr = [
    "ᢗ",
    "",
    "",
    "ᢗ",
    "",
    "",
    "ᢗ",
    "",
    "",
    "ᢖ",
    "",
    ""
  ];
  static final List<String> TArr = [
"ᢙ", "", "", "ᢙ", "", "", "ᢙ", "ᢘ", "", "ᢙᡦ", "", ""
  ];
  static final List<String> DArr = [
    "ᢘ",
    "",
    "",
    "ᢙ",
    "",
    "",
    "ᢘ",
    "",
    "",
    "ᢘᡦ",
    "",
    ""
  ];
  static final List<String> CArr = [
    "ᢦ",
    "",
    "",
    "ᢦ",
    "",
    "",
    "ᢦ",
    "",
    "",
    "ᢦᡦ",
    "",
    ""
  ];
  static final List<String> JArr = [
    "ᡬ",
    "",
    "",
    "ᡬ",
    "",
    "",
    "ᢛ",
    "",
    "",
    "ᢛᡦ",
    "",
    ""
  ];
  static final List<String> YArr = [
    "ᢜ",
    "",
    "",
    "ᢜ",
    "",
    "",
    "ᢜ",
    "",
    "",
    "ᡫ",
    "",
    ""
  ];
  static final List<String> RArr = [
    "ᢞ",
    "",
    "",
    "ᢞ",
    "",
    "",
    "ᢞ",
    "",
    "",
    "ᢝ",
    "",
    ""
  ];
  static final List<String> WArr = [
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟ",
    "",
    "",
    "ᢟᡦ",
    "",
    ""
  ];
  static final List<String> FArr = [
    "ᢡ",
    "",
    "",
    "ᢡ",
    "ᢢ",
    "",
    "ᢡ",
    "ᢢ",
    "",
    "ᢠ",
    "",
    ""
  ];
  static final List<String> KArr = [
    "ᢤ",
    "",
    "",
    "ᢤ",
    "ᢥ",
    "",
    "ᢤ",
    "ᢥ",
    "",
    "ᢣ",
    "",
    ""
  ];
  static final List<String> QArr = [
    "ᢦ",
    "",
    "",
    "ᢦ",
    "",
    "",
    "ᢦ",
    "",
    "",
    "ᢦᡦ",
    "",
    ""
  ];
  static final List<String> ZArr = [
    "ᢨ",
    "",
    "",
    "ᢨ",
    "",
    "",
    "ᢨ",
    "",
    "",
    "ᢨᡦ",
    "",
    ""
  ];
  static final List<String> VArr = [
    "ᡭ",
    "ᡭ",
    "",
    "ᡭ",
    "",
    "",
    "ᡭ",
    "ᡪᡭ",
    "",
    "ᡳ",
    "ᡭ",
    ""
  ];

  static final Map<String, List<String>> wordMap = Map<String, List<String>>();

  static String result = '-1';
  static String resultFirst = "";
  static String resultMid = "";
  static String resultLast = "";

  MWordLogic() {
    print('word logic 构造函数启动');
    wordMap.addAll({"a": aArr});
    wordMap.addAll({"e": eArr});
    wordMap.addAll({"i": iArr});
    wordMap.addAll({"o": oArr});
    wordMap.addAll({"u": uArr});
    wordMap.addAll({"n": nArr});
    wordMap.addAll({"b": bArr});
    wordMap.addAll({"p": pArr});
    wordMap.addAll({"h": hArr});
    wordMap.addAll({"g": gArr});
    wordMap.addAll({"m": mArr});
    wordMap.addAll({"l": lArr});
    wordMap.addAll({"s": sArr});
    wordMap.addAll({"x": xArr});
    wordMap.addAll({"t": tArr});
    wordMap.addAll({"d": dArr});
    wordMap.addAll({"c": cArr});
    wordMap.addAll({"j": jArr});
    wordMap.addAll({"y": yArr});
    wordMap.addAll({"r": rArr});
    wordMap.addAll({"w": wArr});
    wordMap.addAll({"f": fArr});
    wordMap.addAll({"k": kArr});
    wordMap.addAll({"q": qArr});
    wordMap.addAll({"z": zArr});
    wordMap.addAll({"v": vArr});

    wordMap.addAll({"A": AArr});
    wordMap.addAll({"E": eArr});
    wordMap.addAll({"I": iArr});
    wordMap.addAll({"O": oArr});
    wordMap.addAll({"U": UArr});
    wordMap.addAll({"N": nArr});
    wordMap.addAll({"B": bArr});
    wordMap.addAll({"P": pArr});
    wordMap.addAll({"H": hArr});
    wordMap.addAll({"G": gArr});
    wordMap.addAll({"M": mArr});
    wordMap.addAll({"L": LArr});
    wordMap.addAll({"S": sArr});
    wordMap.addAll({"X": xArr});
    wordMap.addAll({"T": TArr});
    wordMap.addAll({"D": DArr});
    wordMap.addAll({"C": CArr});
    wordMap.addAll({"J": jArr});
    wordMap.addAll({"Y": yArr});
    wordMap.addAll({"R": rArr});
    wordMap.addAll({"W": WArr});
    wordMap.addAll({"F": fArr});
    wordMap.addAll({"K": kArr});
    wordMap.addAll({"Q": QArr});
    wordMap.addAll({"Z": ZArr});
    wordMap.addAll({"V": vArr});
  }
  String excute(String latin) {
    int wordLength = latin.length;
    result = "";
    resultFirst = "";
    resultMid = "";
    resultLast = "";
    if (wordLength == 1 && wordMap.containsKey(latin)) {
      print('first if  runs ,latin is :$latin');
      print('wordMap ：${wordMap['a']}');
      resultFirst = wordMap[latin]!.first;
      result = resultFirst;
    } else if (wordLength == 2) {
      firstAndLast(latin);
      result = resultFirst + resultLast;
    } else {
      print('else runs');
      firstAndLast(latin);
      middle(latin);
      result = resultFirst + resultMid + resultLast;
    }

    print(result);
    return result;
  }

  static void firstAndLast(String str) {
    //solving firse letter
    String x = str.substring(0, 1);
    print('on function firstAndLast : $x');

    print('on function firstAndLast : ${wordMap[x]!}');
    resultFirst = wordMap[x]![3];

    //solving b,p,k,f before o,u
    if (x == "b" || x == "p" || x == "k" || x == "f") {
      String y = str.substring(1, 2);
      if (y == "o" || y == "u" || y == "v") {
        resultFirst = wordMap[x]![4];
      }
    }

    // solving h,g before e,i,w
    if (x == 'h' || x == 'g') {
      String y = str.substring(1, 2);
      if (y == 'e' || y == 'i' || y == 'w') {
        resultFirst = wordMap[x]![4];
      }
    }

    //solving h,g before u
    if (x == 'h' || x == 'g') {
      String y = str.substring(1, 2);
      if (y == 'u') {
        resultFirst = wordMap[x]![5];
      }
    }

    //solving last letter;
    resultLast = wordMap[str.substring(str.length - 1)]![9];
    x = str.substring(str.length - 2, str.length - 1);
    print('last x:  $x');
    // solving a after b,p,k,f    test haha  baba
    if (x == 'b' || x == 'p' || x == 'k' || x == 'f') {
      String y = str.substring(str.length - 1);
      if (y == 'a') {
        resultLast = wordMap[y]![10];
      }
    }

    // solving e after h,g
    if (x == 'h' || x == 'g') {
      String y = str.substring(str.length - 1);
      if (y == 'e') {
        resultLast = wordMap[y]![9];
      }
    }
    // solving i after b,p,k,f,h,g
    if (x == 'b' || x == 'p' || x == 'k' || x == 'f' || x == 'h' || x == 'g') {
      String y = str.substring(str.length - 1);
      if (y == 'i') {
        resultLast = wordMap[y]![10];
      }
    }

    // solving o after b,p,k,f
    if (x == 'b' || x == 'p' || x == 'k' || x == 'f') {
      String y = str.substring(str.length - 1);
      if (y == 'o' || y == 'v') {
        resultLast = wordMap[y]![10];
      }
    }
    // solving u after b,p,k,f,h,g
    if (x == 'b' || x == 'p' || x == 'k' || x == 'f' || x == 'h' || x == 'g') {
      String y = str.substring(str.length - 1);
      if (y == 'u') {
        resultLast = wordMap[y]![10];
      }
    }
    // solving g after i,e,u, U
    if (x == 'i' || x == 'e' || x == 'u' || x == 'U') {
      String y = str.substring(str.length - 1);
      if (y == 'g') {
        if (x == 'i') {
          for (int j = 1; j < str.length - 2; j++) {
            String z = str.substring(str.length - 2 - j, str.length - 1 - j);
            if (z == 'a' || z == 'o' || z == 'v') {
              resultLast = wordMap[y]![9];
            } else {
              resultLast = wordMap[y]![11];
            }
          }
        } else {
          resultLast = wordMap[y]![11];
        }
      }
    }

    // solving g after n
    if (x == 'n') {
      String y = str.substring(str.length - 1);
      if (y == 'g') {
        resultLast = wordMap[y]![11];
      }
    }
    // solving a, e after n, m, l, y, r

    if (x == 'n' || x == 'm' || x == 'l' || x == 'y' || x == 'r') {
      String y = str.substring(str.length - 1);
      if (y == 'a' || y == 'e') {
        resultLast = wordMap[y]![11];
      }
    }
    // solving e after c, v, z, q, d
    if (x == 'c' || x == 'v' || x == 'z' || x == 'q' || x == 'd') {
      String y = str.substring(str.length - 1);
      if (y == 'e') {
        resultLast = wordMap[y]![10];
      }
    }
    // solving a, after h, g
    if (x == 'h' || x == 'g') {
      String y = str.substring(str.length - 1);
      if (y == 'a') {
        resultLast = wordMap[y]![11];
      }
    }
    // solving a, after n, m, h, g, for isolated na, ma, ha, ga
    if (x == 'n' || x == 'm' || x == 'h' || x == 'g') {
      String y = str.substring(str.length - 1);
      if (y == 'a') {
        if (str.length == 2) {
          resultLast = wordMap[y]![9];
        }
      }
    }
  }

  static void middle(String str) {
    String m = '';
    for (int i = 1; i < str.length - 1; i++) {
      String x = str.substring(i, i + 1);
      print('x:$x');
      m = wordMap[x]![6];

      //solving g after a or o
      String yy = str.substring(i - 1, i);
      if ((yy == 'a' || yy == 'o' || yy == 'v') && x == 'g') {
        print('solving g after a or o ;x=$x');
        m = wordMap[x]![2];
      }
      //solving g not after a or o
      if ((yy != 'a' && yy != 'o' && yy != 'v') && x == 'g') {
        print('solving g not after a or o;x=$x');
        m = wordMap[x]![7];
      }
      //solving g before a or o
      if (x == "g") {
        String y = str.substring(i + 1, i + 2);
        if (y == "a" || y == "o" || y == "v") {
          print('solving g before a or o;x=$x');
          m = wordMap[x]![6];
        }
      }
      //solving n,d before egshig    a,e,i,o,u, A, E, I, O, U
      if (x == 'n' || x == 'd') {
        String y = str.substring(i + 1, i + 2);
        if (y == 'a' ||
            y == 'e' ||
            y == 'i' ||
            y == 'o' ||
            y == 'v' ||
            y == 'u' ||
            y == 'A' ||
            y == 'E' ||
            y == 'I' ||
            y == 'O' ||
            y == 'V' ||
            y == 'U') {
          print('solving n,d before egshig    a,e,i,o,u, A, E, I, O, U');
          m = wordMap[x]![7];
        }
      }
      //solving b,p,k,f  before o,u
      if (x == 'b' || x == 'p' || x == 'k' || x == 'f') {
        String y = str.substring(i + 1, i + 2);
        if (y == 'o' || y == 'u' || y == 'v') {
          print('solving b,p,k,f  before o,u');
          m = wordMap[x]![7];
        }
      }
      //solving h, g before e, i, w

      if (x == 'h' || x == 'g') {
        String y = str.substring(i + 1, i + 2);
        if (y == 'e' || y == 'i' || y == 'w') {
          print('solving h, g before e, i, w');
          m = wordMap[x]![7];
        }
      }
      //solving h, g before u
      if (x == 'h' || x == 'g') {
        String y = str.substring(i + 1, i + 2);
        if (y == 'u') {
          print('solving h, g before u');
          m = wordMap[x]![8];
        }
      }

      //solving u for second position,    test bumbur  bum

      if (x == 'u' && i == 1) {
        print('solving u for second position,    test bumbur  bum');
        m = wordMap[x]![7];
      }
      //solving i after a, e, o
      if (x == 'i') {
        String y = str.substring(i - 1, i);
        if (y == 'a' || y == 'e' || y == 'o' || y == 'v') {
          print('solving i after a, e, o');
          m = wordMap[x]![7];
        }
        ;
      }
      //solving g after Positive or Negative i traceback
      // test yabogsan uggugsen jarlig jerlig
      if (x == 'g') {
        String y = str.substring(i - 1, i);
        if (y == 'i') {
          print('y equal i ;i=$i');
          String rz = str.substring(i + 1, i + 2);
          if ('a' != rz && rz != 'e' && rz != 'i' && rz != 'o' && rz != 'u') {
            for (int j = 1; j <= i; j++) {
              String z = str.substring(i + 1 - j, i + 2 - j);
              if (z == 'a' || z == 'o' || z == 'v' || z == 'A') {
                m = wordMap[x]![2];
                print('solving g after Positive or Negative i traceback');
              }
            }
          }
        }
      }
      //h, g before a , for second last letter
      if ((x == 'h' || x == 'g') && i == str.length - 2) {
        String y = str.substring(i + 1, i + 2);
        if (y == 'a') {
          m = wordMap[x]![10];
          print('h, g before a , for second last letter');
        }
      }
//n before a, e, for second last letter      test yabona
      if (x == 'n' && i == str.length - 2) {
        String y = str.substring(i + 1, i + 2);
        if (y == 'a' || y == 'e') {
          print('yes !!!n before a, e, for second last letter');
          m = wordMap[x]![10];
        }
      }

      //m, L, y, r before a, e
      if (i == str.length - 2 &&
          (x == 'm' || x == 'L' || x == 'y' || x == 'r')) {
        String y = str.substring(i + 1, i + 2);
        if (y == 'a' || y == 'e') {
          m = wordMap[x]![9];
          print('m, L, y, r before a, e');
        }
      }
      resultMid = resultMid + m;
    }
  }
}
