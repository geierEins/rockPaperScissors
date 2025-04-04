class ResultPanel {

  void showResults() {
    drawBox();
    drawText();
    drawShape();
  }

  void drawBox() {
    RpsType winnerType = countManager.getWinningType();
    int alpha = 100;

    switch(winnerType) {
    case ROCK :
      fill(colorRock, alpha);
      break;
    case PAPER :
      fill(colorPaper, alpha);
      break;
    case SCISSORS :
      fill(colorScissors, alpha);
      break;
    }

    rectMode(CENTER);
    stroke(20, 50);
    strokeWeight(20);
    rect(width/2, height/2, width/3, height/3, 30);
  }

  void drawText() {
    textAlign(CENTER, CENTER);
    textSize(60);
    fill(10);
    text("hat gewonnen!", width/2, height*0.55);

    textSize(25);
    fill(100);
    text("(Klicken für Neustart)", width/2, height*0.61);
  }

  void drawShape() {
    RpsType winnerType = countManager.getWinningType();
    float yShape = height*0.45;
    float xShape = width/2;
    int shapeSize = 150;

    switch(winnerType) {
    case ROCK :
      shape(shapes.get(RpsType.ROCK), xShape, yShape, shapeSize, shapeSize);
      break;
    case PAPER :
      shape(shapes.get(RpsType.PAPER), xShape, yShape, shapeSize, shapeSize);
      break;
    case SCISSORS :
      shape(shapes.get(RpsType.SCISSORS), xShape, yShape, shapeSize, shapeSize);
      break;
    }
  }
}
