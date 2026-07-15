
// Puzzle.pde


// ==================================================
// パズルの親クラス
// ==================================================

class Puzzle extends BaseObject {

  boolean isSolved;
  String puzzleID;


  Puzzle(
    float x,
    float y,
    float w,
    float h,
    String imgPath,
    String id
  ) {

    super(
      "Puzzle",
      "部屋に設置された仕掛け",
      x,
      y,
      w,
      h,
      imgPath
    );

    isSolved = false;
    puzzleID = id;
  }


  @Override
  void display() {

    if (isSolved) {
      fill(100, 220, 120);
    } else {
      fill(230, 180, 80);
    }

    stroke(0);
    rect(x, y, w, h);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);

    if (isSolved) {
      text("CLEAR", x + w / 2, y + h / 2);
    } else {
      text("Puzzle", x + w / 2, y + h / 2);
    }

    noStroke();
  }


  @Override
  void action() {

    if (!isSolved) {

      println("仕掛けを調べています……");

      checkPuzzleLogic();

    } else {

      println("この仕掛けはすでに解除されています。");
    }
  }


  // 基本パズルの処理
  void checkPuzzleLogic() {

    // 通常のPuzzleでは、クリックすると解除される
    isSolved = true;

    println("仕掛けを解除しました！");
  }
}


// ==================================================
// 順番入力パズル
// ==================================================

class SequencePuzzle extends Puzzle {

  ArrayList<Integer> inputSequence;

  int[] correctSequence = {
    3, 1, 4, 2
  };


  SequencePuzzle(
    float x,
    float y,
    float w,
    float h,
    String imgPath,
    String id
  ) {

    super(x, y, w, h, imgPath, id);

    name = "Sequence Puzzle";

    description =
      "正しい順番で数字を押すパズル";

    inputSequence = new ArrayList<Integer>();
  }


  @Override
  void display() {

    fill(210);
    stroke(0);
    rect(x, y, w, h);

    int buttonCount = correctSequence.length;
    float buttonWidth = w / buttonCount;

    for (int i = 0; i < buttonCount; i++) {

      float buttonX = x + i * buttonWidth;

      if (isSolved) {
        fill(100, 220, 120);
      } else {
        fill(180, 200, 250);
      }

      stroke(0);

      rect(
        buttonX,
        y,
        buttonWidth,
        h
      );

      fill(0);
      textAlign(CENTER, CENTER);
      textSize(20);

      text(
        i + 1,
        buttonX + buttonWidth / 2,
        y + h / 2
      );
    }

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(15);

    if (isSolved) {

      text(
        "CLEAR",
        x + w / 2,
        y - 20
      );

    } else {

      text(
        "順番に押してください",
        x + w / 2,
        y - 20
      );
    }

    noStroke();
  }


  @Override
  void action() {

    if (isSolved) {

      println("この順番パズルは解除済みです。");
      return;
    }

    float buttonWidth = w / correctSequence.length;

    int clickedIndex =
      int((mouseX - x) / buttonWidth);

    if (
      clickedIndex >= 0 &&
      clickedIndex < correctSequence.length
    ) {

      int number = clickedIndex + 1;

      addInput(number);
    }
  }


  void addInput(int id) {

    inputSequence.add(id);

    println("現在の入力：" + inputSequence);

    if (
      inputSequence.size() ==
      correctSequence.length
    ) {

      checkLogic();
    }
  }


  void checkLogic() {

    boolean isCorrect = true;

    for (
      int i = 0;
      i < correctSequence.length;
      i++
    ) {

      if (
        inputSequence.get(i) !=
        correctSequence[i]
      ) {

        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {

      isSolved = true;

      println("正解！");
      println("順番パズルを解除しました。");

    } else {

      println("不正解！");
      println("入力をリセットします。");

      inputSequence.clear();
    }
  }
}


// ==================================================
// 色の順番パズル
// ==================================================

class ColorPuzzle extends SequencePuzzle {

  int[] buttonColors = {
    0, 1, 2
  };


  ColorPuzzle(
    float x,
    float y,
    float w,
    float h,
    String imgPath,
    String id
  ) {

    super(x, y, w, h, imgPath, id);

    name = "Color Puzzle";

    description =
      "青、黄、赤の順番で押すパズル";

    correctSequence = new int[] {
      0, 1, 2
    };
  }


  @Override
  void display() {

    float buttonWidth =
      w / buttonColors.length;

    for (
      int i = 0;
      i < buttonColors.length;
      i++
    ) {

      float buttonX =
        x + i * buttonWidth;

      if (i == 0) {
        fill(0, 100, 255);
      }

      if (i == 1) {
        fill(255, 220, 0);
      }

      if (i == 2) {
        fill(255, 50, 50);
      }

      stroke(0);

      rect(
        buttonX,
        y,
        buttonWidth,
        h
      );
    }

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(15);

    if (isSolved) {

      text(
        "CLEAR",
        x + w / 2,
        y - 20
      );

    } else {

      text(
        "青 → 黄 → 赤",
        x + w / 2,
        y - 20
      );
    }

    noStroke();
  }


  @Override
  void action() {

    if (isSolved) {

      println("色パズルは解除済みです。");
      return;
    }

    float buttonWidth =
      w / buttonColors.length;

    int clickedIndex =
      int((mouseX - x) / buttonWidth);

    if (
      clickedIndex >= 0 &&
      clickedIndex < buttonColors.length
    ) {

      addInput(clickedIndex);
    }
  }
}


// ==================================================
// 色が切り替わるボタン
// ==================================================

class ColorButton extends BaseObject {

  int colorID;


  ColorButton(
    float x,
    float y,
    float w,
    float h
  ) {

    super(
      "Color Button",
      "クリックすると色が変わるボタン",
      x,
      y,
      w,
      h,
      ""
    );

    colorID = 0;
  }


  @Override
  void action() {

    // 黒 → 赤 → 白 → 黒
    colorID = (colorID + 1) % 3;

    println(
      "ボタンの色：" + colorID
    );
  }


  @Override
  void display() {

    if (colorID == 0) {

      fill(0);

    } else if (colorID == 1) {

      fill(255, 0, 0);

    } else {

      fill(255);
    }

    stroke(0);

    ellipse(
      x + w / 2,
      y + h / 2,
      w,
      h
    );

    noStroke();
  }
}


// ==================================================
// トランプの色合わせパズル
// ==================================================

class TrumpPuzzle extends Puzzle {

  // トランプ柄の画像
  PImage trampImage;

  // トランプ記号を表示するフォント
  PFont suitFont;

  /*
   * 色の状態
   * 0：黒
   * 1：赤
   *
   * 順番は
   * 0：左上のスペード
   * 1：左中央のダイヤ
   * 2：左下のハート
   * 3：右上のハート
   * 4：右下のクラブ
   */
  int[] suitColors = {
    0, 0, 0, 0, 0
  };

  // 正解の色
  // ♠：黒、♦：赤、♥：赤、♥：赤、♣：黒
  int[] correctPattern = {
    0, 1, 1, 1, 0
  };

  // 表示するトランプ記号
  String[] suitSymbols = {
    "♠", "♦", "♥", "♥", "♣"
  };

  /*
   * 画像内での記号の位置
   * 画像サイズに対する割合で指定
   */
  float[] positionX = {
    0.30,
    0.30,
    0.30,
    0.70,
    0.70
  };

  float[] positionY = {
    0.15,
    0.40,
    0.72,
    0.15,
    0.72
  };

  // クリックできる範囲
  float clickSize = 65;


  TrumpPuzzle(
    float x,
    float y,
    float w,
    float h,
    String imgPath,
    String id
  ) {

    super(
      x,
      y,
      w,
      h,
      imgPath,
      id
    );

    name = "Trump Puzzle";

    description =
      "トランプの柄を赤か黒に合わせるパズル";


    /*
     * tramp.pngがapp.pdeと同じフォルダにあるため、
     * sketchPathを使って直接読み込む
     */
    trampImage =
      loadImage(
        sketchPath(imgPath)
      );


    if (trampImage == null) {

      println(
        "画像を読み込めませんでした：" +
        imgPath
      );
    }


    // トランプ記号を表示するフォント
    suitFont =
      createFont(
        "Segoe UI Symbol",
        60,
        true
      );
  }


  @Override
  void display() {

    // トランプ画像を表示
    if (trampImage != null) {

      image(
        trampImage,
        x,
        y,
        w,
        h
      );

    } else {

      fill(240);
      stroke(0);

      rect(
        x,
        y,
        w,
        h
      );

      fill(0);
      textAlign(CENTER, CENTER);
      textSize(16);

      text(
        "tramp.pngを読み込めません",
        x + w / 2,
        y + h / 2
      );
    }


    // 画像の上に、現在の色の記号を描く
    for (
      int i = 0;
      i < suitSymbols.length;
      i++
    ) {

      float symbolX =
        x + w * positionX[i];

      float symbolY =
        y + h * positionY[i];


      /*
       * 元画像にある黒い記号を白い四角で隠す
       */
      noStroke();
      fill(255);

      rectMode(CENTER);

      rect(
        symbolX,
        symbolY,
        clickSize,
        clickSize
      );

      rectMode(CORNER);


      // 現在の色を設定
      if (suitColors[i] == 0) {

        fill(45);

      } else {

        fill(220, 0, 0);
      }


      textFont(suitFont);
      textAlign(CENTER, CENTER);
      textSize(55);

      text(
        suitSymbols[i],
        symbolX,
        symbolY - 4
      );
    }


    // パズルの説明
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);

    if (isSolved) {

      fill(0, 150, 0);

      text(
        "正解！ドアのロックが解除されました",
        x + w / 2,
        y + h + 28
      );

    } else {

      text(
        "柄をクリックして赤・黒を切り替えよう",
        x + w / 2,
        y + h + 28
      );
    }
  }


  // どれかの柄がクリックされたか確認
  @Override
  boolean isClicked(
    float mx,
    float my
  ) {

    for (
      int i = 0;
      i < suitSymbols.length;
      i++
    ) {

      float symbolX =
        x + w * positionX[i];

      float symbolY =
        y + h * positionY[i];


      if (
        mx >= symbolX - clickSize / 2 &&
        mx <= symbolX + clickSize / 2 &&
        my >= symbolY - clickSize / 2 &&
        my <= symbolY + clickSize / 2
      ) {

        return true;
      }
    }

    return false;
  }


  // 柄がクリックされたとき
  @Override
  void action() {

    if (isSolved) {

      println(
        "トランプパズルは解除済みです。"
      );

      return;
    }


    for (
      int i = 0;
      i < suitSymbols.length;
      i++
    ) {

      float symbolX =
        x + w * positionX[i];

      float symbolY =
        y + h * positionY[i];


      if (
        mouseX >= symbolX - clickSize / 2 &&
        mouseX <= symbolX + clickSize / 2 &&
        mouseY >= symbolY - clickSize / 2 &&
        mouseY <= symbolY + clickSize / 2
      ) {

        // 黒と赤を切り替える
        suitColors[i] =
          (suitColors[i] + 1) % 2;


        if (suitColors[i] == 0) {

          println(
            suitSymbols[i] +
            "を黒にしました"
          );

        } else {

          println(
            suitSymbols[i] +
            "を赤にしました"
          );
        }


        checkLogic();

        break;
      }
    }
  }


  // 正解判定
  void checkLogic() {

    boolean allMatch = true;


    for (
      int i = 0;
      i < correctPattern.length;
      i++
    ) {

      if (
        suitColors[i] !=
        correctPattern[i]
      ) {

        allMatch = false;
        break;
      }
    }


    if (allMatch) {

      isSolved = true;

      println(
        "トランプの色がすべて揃いました！"
      );

      println(
        "トランプパズルを解除しました。"
      );
    }
  }
}
// ==================================================
// ノックパズル
// ==================================================

class KnockPuzzle extends Puzzle {

  int knockCount;
  int targetCount;


  KnockPuzzle(
    float x,
    float y,
    float w,
    float h,
    String id
  ) {

    super(
      x,
      y,
      w,
      h,
      "",
      id
    );

    name = "Knock Puzzle";

    description =
      "決められた回数クリックするパズル";

    knockCount = 0;

    // テストしやすいように100回に設定
    targetCount = 100;
  }


  @Override
  void display() {

    if (isSolved) {
      fill(100, 220, 120);
    } else {
      fill(150, 100, 60);
    }

    stroke(0);

    rect(
      x,
      y,
      w,
      h
    );

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(16);

    if (isSolved) {

      text(
        "CLEAR",
        x + w / 2,
        y + h / 2
      );

    } else {

      text(
        "KNOCK\n" +
        knockCount +
        " / " +
        targetCount,
        x + w / 2,
        y + h / 2
      );
    }

    noStroke();
  }


  @Override
  void action() {

    if (isSolved) {

      println("ノックパズルは解除済みです。");
      return;
    }

    knockCount++;

    println(
      "ノック回数：" +
      knockCount
    );

    if (
      knockCount >= targetCount
    ) {

      isSolved = true;

      println("ノックパズルを解除しました！");
    }
  }
}
