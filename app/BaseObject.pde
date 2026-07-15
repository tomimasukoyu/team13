// BaseObject.pde

class BaseObject {

  String name;
  String description;
  String imgPath;

  float x;
  float y;
  float w;
  float h;

  BaseObject(
    String name,
    String description,
    float x,
    float y,
    float w,
    float h,
    String imgPath
  ) {

    this.name = name;
    this.description = description;

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.imgPath = imgPath;
  }


  // オブジェクトを表示する
  void display() {

    fill(200);
    stroke(0);
    rect(x, y, w, h);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(name, x + w / 2, y + h / 2);

    noStroke();
  }


  // オブジェクトがクリックされたか調べる
  boolean isClicked(float mx, float my) {

    return mx >= x &&
           mx <= x + w &&
           my >= y &&
           my <= y + h;
  }


  // オブジェクトを調べる
  void inspect() {

    println(name + "：" + description);
  }


  // クリックされたときの動作
  void action() {

    inspect();
  }


  // 毎フレーム行う更新処理
  void update() {

    // 必要なクラスでオーバーライドする
  }
}
