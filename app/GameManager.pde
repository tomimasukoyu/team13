// GameManager.pde

class GameManager {

  // 画面番号
  final int SCENE_STAGE_SELECT = 0;
  final int SCENE_GAME = 1;
  final int SCENE_CLEAR = 2;

  int scene;
  int stage;

  StageSelect stageSelect;

  ArrayList<BaseObject> objects;
  ArrayList<Puzzle> puzzles;

  Door door;


  GameManager() {

    scene = SCENE_STAGE_SELECT;
    stage = 0;

    stageSelect = new StageSelect();

    objects = new ArrayList<BaseObject>();
    puzzles = new ArrayList<Puzzle>();
  }


  // 毎フレームの更新処理
  void update() {

    if (scene != SCENE_GAME) {
      return;
    }

    // 全オブジェクトの更新処理
    for (BaseObject object : objects) {
      object.update();
    }

    // 全パズルが解けたか確認
    if (door != null) {
      door.checkUnlock(puzzles);
    }
  }


  // 現在の画面を表示
  void display() {

    if (scene == SCENE_STAGE_SELECT) {

      stageSelect.display();

    } else if (scene == SCENE_GAME) {

      displayGame();

    } else if (scene == SCENE_CLEAR) {

      displayClear();
    }
  }


  // ゲーム画面の表示
  void displayGame() {

    background(235);

    // 床
    fill(190);
    noStroke();
    rect(0, 450, width, 150);

    // ステージ名
    fill(0);
    textAlign(LEFT, TOP);
    textSize(24);
    text("Stage " + stage, 20, 20);

    textSize(15);
    text("パズルを解いてドアを開けよう", 20, 55);

    // 全オブジェクトを表示
    for (BaseObject object : objects) {
      object.display();
    }

    // 操作説明
    fill(0);
    textAlign(LEFT, BOTTOM);
    textSize(14);

    text(
      "Rキー：ステージをやり直す",
      20,
      height - 20
    );

    text(
      "Bキー：ステージ選択へ戻る",
      250,
      height - 20
    );
  }


  // クリア画面の表示
  void displayClear() {

    background(180, 230, 255);

    fill(0);
    textAlign(CENTER, CENTER);

    textSize(40);
    text(
      "STAGE CLEAR!",
      width / 2,
      200
    );

    textSize(22);
    text(
      "Stage " + stage + " をクリアしました",
      width / 2,
      270
    );


    // 次のステージボタン
    if (stage < 3) {

      fill(100, 200, 120);
      stroke(0);

      rect(
        250,
        330,
        300,
        70
      );

      fill(0);
      textSize(20);

      text(
        "Next Stage",
        width / 2,
        365
      );
    }


    // ステージ選択へ戻るボタン
    fill(230);
    stroke(0);

    rect(
      250,
      430,
      300,
      70
    );

    fill(0);
    textSize(20);

    text(
      "Stage Select",
      width / 2,
      465
    );

    noStroke();
  }


  // ステージの読み込み
  void loadStage() {

    objects.clear();
    puzzles.clear();

    door = null;


    switch(stage) {

    // ==================================================
    // Stage 1：ノックパズル
    // ==================================================
    case 1:

      // 画面中央にドアを配置
      door = new Door(
        width / 2 - 60,
        120,
        120,
        280,
        ""
      );

      KnockPuzzle knockPuzzle = new KnockPuzzle(
        100,
        330,
        140,
        100,
        "knock01"
      );

      addPuzzle(knockPuzzle);
      objects.add(door);

      break;


    // ==================================================
    // Stage 2：順番入力パズル
    // 正解：3 → 1 → 4 → 2
    // ==================================================
    case 2:

      // 画面中央にドアを配置
      door = new Door(
        width / 2 - 60,
        100,
        120,
        280,
        ""
      );

      SequencePuzzle sequencePuzzle =
        new SequencePuzzle(
          100,
          430,
          600,
          80,
          "",
          "sequence01"
        );

      addPuzzle(sequencePuzzle);
      objects.add(door);

      break;


    // ==================================================
    // Stage 3：トランプの色合わせパズル
    // 正解：黒・赤・赤・黒
    // ==================================================
    case 3:

  door = new Door(
    width / 2 - 60,
    100,
    120,
    280,
    ""
  );

  TrumpPuzzle trumpPuzzle =
    new TrumpPuzzle(
      70,
      130,
      220,
      240,
      "tramp.png",
      "trump01"
    );

  addPuzzle(trumpPuzzle);
  objects.add(door);

  break;
    }
  }
  
  // パズルをリストへ登録
  void addPuzzle(Puzzle puzzle) {

    puzzles.add(puzzle);
    objects.add(puzzle);
  }


  // ステージクリア
  void clearStage() {

    scene = SCENE_CLEAR;

    println(
      "Stage " +
      stage +
      " Clear!"
    );
  }


  // 次のステージへ進む
  void nextStage() {

    if (stage < 3) {

      stage++;

      loadStage();

      scene = SCENE_GAME;

    } else {

      backToSelect();
    }
  }


  // ステージ選択画面へ戻る
  void backToSelect() {

    scene = SCENE_STAGE_SELECT;

    stage = 0;

    objects.clear();
    puzzles.clear();

    door = null;
  }


  // 現在のステージをやり直す
  void restartStage() {

    if (stage >= 1 && stage <= 3) {

      loadStage();

      scene = SCENE_GAME;

      println(
        "Stage " +
        stage +
        " をやり直します"
      );
    }
  }


  // マウスクリック処理
  void mousePressed() {

    // ==================================================
    // ステージ選択画面
    // ==================================================
    if (scene == SCENE_STAGE_SELECT) {

      int result = stageSelect.mousePressed();

      if (result != 0) {

        stage = result;

        loadStage();

        scene = SCENE_GAME;

        println(
          "Stage " +
          stage +
          " Start!"
        );
      }

      return;
    }


    // ==================================================
    // ゲーム画面
    // ==================================================
    if (scene == SCENE_GAME) {

      for (BaseObject object : objects) {

        if (object.isClicked(mouseX, mouseY)) {

          object.action();


          // パズル操作後にドアの解錠確認
          if (door != null) {
            door.checkUnlock(puzzles);
          }


          // ロック解除後のドアをクリックしたらクリア
          if (
            object == door &&
            !door.isLocked
          ) {

            clearStage();
          }

          // 複数のオブジェクトを同時に押さない
          break;
        }
      }

      return;
    }


    // ==================================================
    // クリア画面
    // ==================================================
    if (scene == SCENE_CLEAR) {

      // 次のステージへ
      if (
        stage < 3 &&
        mouseX >= 250 &&
        mouseX <= 550 &&
        mouseY >= 330 &&
        mouseY <= 400
      ) {

        nextStage();

        return;
      }


      // ステージ選択画面へ戻る
      if (
        mouseX >= 250 &&
        mouseX <= 550 &&
        mouseY >= 430 &&
        mouseY <= 500
      ) {

        backToSelect();
      }
    }
  }


  // キーボード操作
  void keyPressed() {

    if (scene != SCENE_GAME) {
      return;
    }


    // Rキーでやり直し
    if (
      key == 'r' ||
      key == 'R'
    ) {

      restartStage();
    }


    // Bキーでステージ選択へ戻る
    if (
      key == 'b' ||
      key == 'B'
    ) {

      backToSelect();
    }
  }
}
