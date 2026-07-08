class BaseObject {
  String name;
  String description;
  float x;
  float y;
  float w;
  float h;

  BaseObject(String name, String description, float x, float y, float w, float h) {
    this.name = name;
    this.description = description;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, x + w / 2, y + h / 2);
  }

  boolean isClicked(float mouseX, float mouseY) {
    return mouseX >= x && mouseX <= x + w &&
           mouseY >= y && mouseY <= y + h;
  }

  void inspect() {
    println(description);
  }
}