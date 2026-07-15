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

class SequencePuzzle extends Puzzle {
    ArrayList<Integer> inputSequence; // 入力された順番を記録
    int[] correctSequence = {3, 1, 4, 2}; // 正解の順番

SequencePuzzle(float x, float y, float w, float h, String imgPath, String id) {
    super(x, y, w, h, imgPath, id); // 親クラスの id も渡すように修正
    inputSequence = new ArrayList<Integer>();
}

    // ボタンが押されたときに呼び出す
    void addInput(int id) {
        inputSequence.add(id);
        println("現在の入力: " + inputSequence);
        
        // 4つ入力されたら判定
        if(inputSequence.size() == correctSequence.length){
            checkLogic();
        }
    }

    void checkLogic() {
        // 正誤判定ロジック
        boolean isCorrect = true;
        for (int i = 0; i < correctSequence.length; i++){
            if(inputSequence.get(i) != correctSequence[i]) {
                isCorrect = false;
            }
        }
        
        if (isCorrect) {
            println("正解！扉が開きます");
            // ここで Door クラスのロックを解除する処理などへつなげる
        } else {
            println("不正解！リセットします");
            inputSequence.clear(); // 間違えたらリセット
        }
    }
}

class ColorPuzzle extends SequencePuzzle {
    
    // 青=0, 黄=1, 赤=2 と定義
    ColorPuzzle(float x, float y, float w, float h, String imgPath, String id) {
        super(x, y, w, h, imgPath, id);
        // 色の正解順を設定（青→黄→赤）
        this.correctSequence = new int[]{0, 1, 2}; 
    }
    
    // 必要に応じて、色パズル専用の動作を追加可能
}

class ColorButton extends BaseObject {
    int colorID; // 0:黒, 1:赤, 2:白

    ColorButton(float x, float y, float w, float h) {
        super(x, y, w, h, ""); // 画像パスは一旦空
        this.colorID = 0; // 初期値は黒
    }

    // クリックされたら色を変える
    @Override
    void action() {
        colorID = (colorID + 1) % 3; // 0→1→2→0 とループ
        println("ボタンの色が変わりました: " + colorID);
    }

    // 色に応じて描画（Processing標準の機能を利用）
    void display() {
        if (colorID == 0) fill(0);      // 黒
        else if (colorID == 1) fill(255, 0, 0); // 赤
        else fill(255);                 // 白
        ellipse(x + w/2, y + h/2, w, h);
    }
}

class TrumpPuzzle extends Puzzle {
    ColorButton[] buttons;
    int[] correctPattern = {0, 1, 1, 0}; // スペード(黒), ダイヤ(赤), ハート(赤), クラブ(黒)の例

    TrumpPuzzle(float x, float y, float w, float h, String id) {
        super(x, y, w, h, "", id);
        buttons = new ColorButton[4];
        for (int i = 0; i < 4; i++) {
            buttons[i] = new ColorButton(x + (i * 60), y, 50, 50);
        }
    }

    void checkLogic() {
        boolean allMatch = true;
        for (int i = 0; i < 4; i++) {
            if (buttons[i].colorID != correctPattern[i]) {
                allMatch = false;
            }
        }
        
        if (allMatch) {
            isSolved = true;
            println("色が揃いました！正解です。");
        }
    }
}

// Puzzle.pde に追加
class KnockPuzzle extends Puzzle {
    int knockCount = 0;
    int targetCount = 100;

    KnockPuzzle(float x, float y, float w, float h, String id) {
        super(x, y, w, h, "", id);
    }

    @Override
    void action() {
        if (!isSolved) {
            knockCount++;
            println("ノック回数: " + knockCount);
            
            if (knockCount >= targetCount) {
                isSolved = true;
                println("ドアがノックに反応して開きました！");
            }
        }
    }
}
