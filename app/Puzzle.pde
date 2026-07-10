// Puzzle.pde
class Puzzle extends BaseObject {
    boolean isSolved;     // 仕掛けが解けたかどうかの状態フラグ
    String puzzleID;      // どのパズルか識別するためのID

    Puzzle(float x, float y, float w, float h, String imgPath, String id) {
        super(x, y, w, h, imgPath); // 親クラスのコンストラクタを呼び出し
        this.isSolved = false;
        this.puzzleID = id;
    }

    // 具体的な動作を定義（ポリモーフィズム）
    @Override
    void action() {
        if (!isSolved) {
            // ここでパズル画面を開く、あるいはパスワード入力処理などを行う
            println("仕掛けを調べています...");
            checkPuzzleLogic(); 
        } else {
            println("この仕掛けは既に解除済みです。");
        }
    }

    void checkPuzzleLogic() {
        // パスワード入力や、特定のアイテムが使われたかどうかの判定
        // 例: if (hasItem("Key")) { isSolved = true; }
    }
}