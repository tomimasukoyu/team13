// app.pde

GameManager gm;
PFont japaneseFont;

void setup() {

  size(800, 600);

  japaneseFont = createFont(
    "Meiryo",
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
