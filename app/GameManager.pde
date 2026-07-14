class GameManager {

    ArrayList<BaseObject> objects;

    StageSelect stageSelect;

    int scene; 
    int stage;


    GameManager() {

        scene = 0; //ステージ選択画面
        stage = 0;
        stageSelect = new StageSelect();

    }


    void update() {

        if(scene == 1) {

            for(BaseObject obj : objects) {
                obj.update();
            }

        }

    }

    void clearStage() {

        scene = 2;

    }

    void nextStage() {

        stage++;

        loadStage();

        scene = 1;

    }

    void backToSelect() {

        scene = 0;

    }


    void loadStage() {

        objects = new ArrayList<BaseObject>();

        switch(stage) {

        case 1:
            objects.add(new Door(600, 200, 100, 200));
            objects.add(new Puzzle(100, 400, 50, 50));
            break;


        case 2:
            objects.add(new Door(600, 200, 100, 200));
            break;

        }

    }


    void display() {

        if(scene == 0) {

            stageSelect.display();

        }
        else {

            for(BaseObject obj : objects) {
                obj.display();
            }

        }

    }


    void mousePressed() {


        if(scene == 0) {

            int result = stageSelect.mousePressed();


            if(result != 0) {

                stage = result;

                loadStage();

                scene = 1;

            }

        }
        else {


            for(BaseObject obj : objects) {

                if(obj.isClicked(mouseX, mouseY)) {

                    obj.action();

                }

            }

        }

    }

}