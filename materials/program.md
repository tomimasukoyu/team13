# クラス名

## app.pde
   ゲームを起動するメインファイル。

   【属性（変数）一覧】

   * GameManager gm

   ゲーム全体を管理するオブジェクト
   シーン遷移やステージ管理を担当する

---
   【メソッド一覧】

   * void setup()

   プログラム開始時に1回だけ実行される
   ウィンドウサイズを設定する
   GameManager を生成する

   * void draw()

   毎フレーム実行される
   GameManager の display() を呼び出して画面を描画する

   * void mousePressed()

   マウスクリック時に実行される
   GameManager の mousePressed() を呼び出す

## GameManeger.pde(ステージ番号)
   ゲーム全体の進行を管理するクラス。

   【属性（変数）一覧】

   ArrayList<BaseObject> objects

   ステージ内に配置されるオブジェクトを管理するリスト

   * StageSelect stageSelect

   ステージ選択画面を管理するオブジェクト

   * int scene

   現在の画面状態を表す変数
   0：ステージ選択画面
   1：ゲーム画面
   2：ステージクリア画面

   * int stage

   現在のステージ番号

---
   【メソッド一覧】

   * GameManager()

   コンストラクタ
   初期画面をステージ選択画面に設定する

   * void clearStage()

   ステージクリア時に呼び出される
   scene をクリア画面に変更する

   * void nextStage()

   次のステージへ進む
   stage を増加させて loadStage() を実行する

   * void backToSelect()

   ステージ選択画面へ戻る

   * void loadStage()

   ステージ番号に応じてオブジェクトを生成する
   Door や Puzzle を objects に追加する

   * void display()

   現在の scene に応じた画面描画を行う

   * void mousePressed()

   マウスクリック時の処理
   ステージ選択またはオブジェクトの action() を実行する

   役割：
   現在のステージ番号を管理する。
   ステージ開始、ステージクリア、次のステージへの移動を行う。

## StageSelect.pde

   【属性（変数）一覧】

   * int selectedStage

   選択されたステージ番号を保持するための変数
   現在は未使用

---

   【メソッド一覧】

   * StageSelect()

   コンストラクタ

   * void display()

   ステージ選択画面を描画する
   タイトルと各ステージのドアを表示する

   * void drawDoor(int x, int y, int w, int h, String stageName)

   ドア型のステージボタンを描画する

   * int mousePressed()

   クリックされたドアを判定する
   Stage1～3 に応じて 1～3 を返す
   何も押されなければ 0 を返す

   役割：

   ステージ選択画面専用のクラス
   クリックされたステージ番号を GameManager に返す

## Item.pde
鍵やメモなど、プレイヤーが見つけたり使ったりするもの。

役割：
ステージ内にあるアイテムを管理する。
ドアを開けるための鍵や、謎解きのヒントになるメモなどを扱う。
## BaseObject.pde(すべてのオブジェクトの親クラス)
すべてのオブジェクトの親クラス。

役割：
Item、Door、Puzzle に共通する情報や動作をまとめる。

## Door.pde
ステージの出口になるドア。

役割：
ドアが開くかどうかを管理する。
アイテムや謎解きの結果によってロックを解除する。
## Puzzle.pde
暗号や謎解きを管理するクラス。

役割：
ステージごとの謎を管理する。
答えが正しいか判定し、正解ならドアを開けられる状態にする。