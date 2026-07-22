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

      println("仕掛けを調べています");

      checkPuzzleLogic();

    } else {

      println("この仕掛けは解除済みです");
    }
  }


  void checkPuzzleLogic() {

    isSolved = true;

    println("仕掛けを解除しました");
  }
}


// ==================================================
// Stage2：順番入力パズル
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

    super(
      x,
      y,
      w,
      h,
      imgPath,
      id
    );

    name = "Sequence Puzzle";
    description = "正しい順番で数字を押すパズル";

    inputSequence = new ArrayList<Integer>();
  }


  @Override
  void display() {

  // 時計を表示
// 左
drawClock(x + 80,  y - 100, 3);
drawClock(x + 160, y - 100, 1);

// 右
drawClock(x + 420, y - 100, 4);
drawClock(x + 500, y - 100, 2);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(15);

  if (isSolved) {

    text(
      "CLEAR",
      x + w / 2,
      y - 35
    );

  } else {

    text(
      "順番に押せ",
      x + w / 2,
      y - 35
    );
  }


  // 数字ボタンの背景
  fill(210);
  stroke(0);
  rect(x, y, w, h);

  int buttonCount = correctSequence.length;

  float buttonWidth =
    w / buttonCount;


  for (
    int i = 0;
    i < buttonCount;
    i++
  ) {

    float buttonX =
      x + i * buttonWidth;


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


  noStroke();
  }


  // 時計を描く関数
  void drawClock(
    float cx,
    float cy,
    int hour
  ) {

    // 時計の外枠
    fill(255);
    stroke(0);
    strokeWeight(2);
    ellipse(cx, cy, 50, 50);

    // 12時・3時・6時・9時の目盛り
    line(cx, cy - 20, cx, cy - 15);
    line(cx + 20, cy, cx + 15, cy);
    line(cx, cy + 20, cx, cy + 15);
    line(cx - 20, cy, cx - 15, cy);

    // 長針は12時方向
    strokeWeight(2);
    line(cx, cy, cx, cy - 20);

    // 短針
    float angle =
      radians(hour * 30 - 90);

    strokeWeight(4);
    line(
      cx,
      cy,
      cx + cos(angle) * 14,
      cy + sin(angle) * 14
    );

    // 時計の中心
    fill(0);
    noStroke();
    ellipse(cx, cy, 6, 6);

    strokeWeight(1);
  }


  @Override
  void action() {

    if (isSolved) {

      println("順番パズルは解除済みです");
      return;
    }


    float buttonWidth =
      w / correctSequence.length;


    int clickedIndex =
      int(
        (mouseX - x) /
        buttonWidth
      );


    if (
      clickedIndex >= 0 &&
      clickedIndex < correctSequence.length
    ) {

      int number =
        clickedIndex + 1;

      addInput(number);
    }
  }


  void addInput(int number) {

    inputSequence.add(number);

    println(
      "現在の入力：" +
      inputSequence
    );


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

      println("順番パズル正解");

    } else {

      println("順番が違います");
      println("入力をリセットします");

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

    super(
      x,
      y,
      w,
      h,
      imgPath,
      id
    );

    name = "Color Puzzle";
    description = "青、黄、赤の順番で押すパズル";

    correctSequence =
      new int[] {
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

      } else if (i == 1) {

        fill(255, 220, 0);

      } else {

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
    }
    noStroke();
  }


  @Override
  void action() {

    if (isSolved) {

      println("色パズルは解除済みです");
      return;
    }


    float buttonWidth =
      w / buttonColors.length;


    int clickedIndex =
      int(
        (mouseX - x) /
        buttonWidth
      );


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

    colorID =
      (colorID + 1) % 3;
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
// Stage3：トランプの色合わせパズル
// ==================================================

class TrumpPuzzle extends Puzzle {

  PImage trampImage;
  PFont suitFont;


  // 0：黒
  // 1：赤
  int[] suitColors = {
    0, 0, 0, 0, 0
  };


  // ♠黒、♦赤、♥赤、♥赤、♣黒
  int[] correctPattern = {
    0, 1, 1, 1, 0
  };


  String[] suitSymbols = {
    "♠", "♦", "♥", "♥", "♣"
  };


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


    trampImage =
      loadImage(
        sketchPath(imgPath)
      );


    if (trampImage == null) {

      println(
        "画像を読み込めません：" +
        imgPath
      );
    }


    suitFont =
      createFont(
        "Segoe UI Symbol",
        60,
        true
      );
  }


  @Override
  void display() {

    textFont(japaneseFont);


    if (trampImage != null) {

      image(
        trampImage,
        x,
        y,
        w,
        h
      );
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


    textFont(japaneseFont);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);


    if (isSolved) {
      fill(0, 150, 0);
      text(
        "CLEAR",
        x + w / 2,
        y + h + 28
      );
    }
  }


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


  @Override
  void action() {

    if (isSolved) {

      println("Trump Puzzle Clear");
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

        suitColors[i] =
          (suitColors[i] + 1) % 2;


        checkLogic();

        break;
      }
    }
  }


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
        "Trump Puzzle Clear"
      );
    }
  }
}


// ==================================================
// Stage1：ノックパズル
// ==================================================

class KnockPuzzle extends Puzzle {

  int knockCount;
  int targetCount;
  boolean isLocked;


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
    description = "30回ノックするパズル";

    knockCount = 0;
    targetCount = 30;
    isLocked = true;
  }


  @Override
  void display() {

    stroke(70, 40, 20);
    strokeWeight(5);

    // ロック中と解除後で色を変える
    if (isLocked) {
      fill(120, 70, 30);
    } else {
      fill(180, 120, 60);
    }

    rect(x, y, w, h);


    // ドアノブ
    fill(255, 215, 0);
    noStroke();

    ellipse(
      x + w - 20,
      y + h / 2,
      15,
      15
    );


    // ドアの状態またはノック回数の表示
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);

    if (isLocked) {
      text(
        "LOCKED",
        x + w / 2,
        y + 35
      );
    } else {
      text(
        "OPEN",
        x + w / 2,
        y + 35
      );
    }
  }

  @Override
  void action() {

    if (!isLocked) {
      println("ドアを開けました！");
      return;
    }

    knockCount++;
    println("ノック！ (" + knockCount + "/" + targetCount + ")");


    if (knockCount >= targetCount) {
      isSolved = true;
      isLocked = false;

      println("全ての謎が解けました！");
      println("ドアのロックが解除されました！");
    }
  }
}
