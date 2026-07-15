// Door.pde

class Door extends BaseObject {

  boolean isLocked;


  Door(
    float x,
    float y,
    float w,
    float h,
    String imgPath
  ) {

    super(
      "Door",
      "出口のドア",
      x,
      y,
      w,
      h,
      imgPath
    );

    isLocked = true;
  }


  // 全てのパズルが解けたか確認
  void checkUnlock(ArrayList<Puzzle> puzzleList) {

    // すでに解除されている場合
    if (!isLocked) {
      return;
    }

    // パズルが存在しない場合
    if (puzzleList.size() == 0) {
      return;
    }

    boolean allCleared = true;

    for (Puzzle puzzle : puzzleList) {

      if (!puzzle.isSolved) {

        allCleared = false;
        break;
      }
    }

    if (allCleared) {

      isLocked = false;

      println("全ての謎が解けました！");
      println("ドアのロックが解除されました！");
    }
  }


  // ドアは動かさない
  @Override
  void update() {

  }


  // ドアの表示
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


    // ドアの状態
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


  // ドアのクリック判定
  @Override
  boolean isClicked(float mx, float my) {

    return mx >= x &&
           mx <= x + w &&
           my >= y &&
           my <= y + h;
  }


  // ドアをクリックしたとき
  @Override
  void action() {

    if (isLocked) {

      println("ドアには鍵がかかっています。");
      println("部屋の謎を全て解いてください。");

    } else {

      println("ドアを開けました！");
    }
  }
}
