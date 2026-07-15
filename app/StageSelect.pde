// StageSelect.pde

class StageSelect {

  int selectedStage;


  StageSelect() {

    selectedStage = 0;
  }


  // ステージ選択画面
  void display() {

    background(220);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(30);

    text(
      "Stage Select",
      width / 2,
      80
    );

    drawDoor(
      170,
      120,
      120,
      220,
      "Stage 1"
    );

    drawDoor(
      510,
      120,
      120,
      220,
      "Stage 2"
    );

    drawDoor(
      170,
      350,
      120,
      220,
      "Stage 3"
    );

    drawDoor(
      510,
      350,
      120,
      220,
      "Stage 4"
    );

    fill(0);
    textSize(16);

    text(
      "遊びたいステージのドアをクリック",
      width / 2,
      500
    );
  }


  void drawDoor(
    int x,
    int y,
    int w,
    int h,
    String stageName
  ) {

    // ドア本体
    fill(139, 69, 19);
    stroke(80, 40, 10);
    strokeWeight(4);

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

    // ステージ名
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);

    text(
      stageName,
      x + w / 2,
      y + 40
    );
  }


  // クリックされたステージ番号を返す
  int mousePressed() {

    if (
      mouseX >= 170 &&
      mouseX <= 290 &&
      mouseY >= 120 &&
      mouseY <= 340
    ) {

      return 1;
    }


    if (
      mouseX >= 510 &&
      mouseX <= 630 &&
      mouseY >= 120 &&
      mouseY <= 340
    ) {

      return 2;
    }


    if (
      mouseX >= 170 &&
      mouseX <= 290 &&
      mouseY >= 350 &&
      mouseY <= 570
    ) {

      return 3;
    }

    if(
      mouseX >= 510 &&
      mouseX <= 630 &&
      mouseY >= 350 && 
      mouseY <= 570
      ){

      return 4;
    }


    return 0;
  }
}
