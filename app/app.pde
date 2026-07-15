// app.pde

GameManager gm;
PFont japaneseFont;

void setup() {

  size(800, 600);

  // 日本語フォントを読み込む
  japaneseFont = createFont(
    "Yu Gothic",
    20,
    true
  );

  textFont(japaneseFont);

  gm = new GameManager();
}

void draw() {

  gm.update();
  gm.display();
}

void mousePressed() {

  gm.mousePressed();
}

void keyPressed() {

  gm.keyPressed();
}
