// app.pde
ArrayList<BaseObject> objects; // 画面上のオブジェクトを管理するリスト

void setup() {
    size(800, 600);
    objects = new ArrayList<BaseObject>();
    // ステージごとの初期配置（ここをステージごとに切り替える）
    objects.add(new Door(600, 200, 100, 200, "door.png"));
    objects.add(new PickupItem(100, 400, 50, 50, "key.png"));
}

void draw() {
    background(200);
    // すべてのオブジェクトに描画を依頼
    for (BaseObject obj : objects) {
        obj.display();
    }
}

void mousePressed() {
    // クリックされたオブジェクトを探す
    for (BaseObject obj : objects) {
        if (obj.isClicked(mouseX, mouseY)) {
            obj.action(); // 動作を実行
        }
    }
}