// Door.pde
class Door extends BaseObject {
    boolean isLocked = true;
    float doorX; // ドアの現在のX位置
    float targetX; // 開いた時の目標位置
    
    Door(float x, float y, float w, float h, String imgPath) {
        super(x, y, w, h, imgPath);
        this.doorX = x;
        this.targetX = x + 100; // 右に100px移動して開く設定
    }

    // 全てのパズルをチェックして、クリアされていたら解錠する
    void checkUnlock(ArrayList<Puzzle> puzzleList) {
        if (!isLocked) return; // 既に開いていれば何もしない

        boolean allCleared = true;
        for (Puzzle p : puzzleList) {
            if (!p.isSolved) {
                allCleared = false;
                break;
            }
        }

        if (allCleared) {
            isLocked = false;
            println("全ての謎が解けました！ドアが開きます！");
        }
    }

    // ドアのアニメーション更新
    void update() {
        if (!isLocked && doorX < targetX) {
            doorX += 2; // スライド速度
        }
    }

    // ドアの描画
    @Override
    void display() {
        // 画像がある場合は image(img, doorX, y, w, h); を使用
        // ここでは便宜上、四角形で表現
        fill(100);
        rect(doorX, y, w, h);
    }
}