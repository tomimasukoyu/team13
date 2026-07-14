class StageSelect {

  int selectedStage = 0;

  StageSelect() {

  }


  // ステージ選択画面の描画
  void display() {

    background(220);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("Stage Select", width/2, 100);

    drawDoor(100, 150, 150, 250, "Stage 1");
    drawDoor(325, 150, 150, 250, "Stage 2");
    drawDoor(550, 150, 150, 250, "Stage 3");
  
  }

  void drawDoor(int x, int y, int w, int h, String stageName) {

    // ドア本体
    fill(139, 69, 19);
    rect(x, y, w, h);

    // ドア枠
    stroke(80, 40, 10);
    strokeWeight(4);
    noFill();
    rect(x, y, w, h);

    // ドアノブ
    fill(255, 215, 0);
    ellipse(x + w - 20, y + h/2, 15, 15);

    // ステージ名
    fill(255);
    textSize(20);
    text(stageName, x + w/2, y + 40);

    noStroke();
  }

  int mousePressed() {

    if(mouseX >= 100 && mouseX <= 250 &&
       mouseY >= 200 && mouseY <= 300){

      return 1;

    }


    if(mouseX >= 325 && mouseX <= 475 &&
       mouseY >= 200 && mouseY <= 300){

      return 2;

    }


    if(mouseX >= 550 && mouseX <= 700 &&
       mouseY >= 200 && mouseY <= 300){

      return 3;

    }


    return 0; 

  }

}