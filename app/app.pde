// app.pde

GameManager gm;

void setup() {
    size(800,600);
    gm = new GameManager();
}

void draw() {
    gm.display();
}

void mousePressed() {
    gm.mousePressed();
}