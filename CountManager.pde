class CountManager {

  void run() {
    updateItemCount();
    drawItemCounts();
  }

  void drawItemCounts() {
    int shapeSize = 80;
    int minCircleSize = 50;
    int maxCirclesSize = 300;
    float rockCircleSize = map(counts.get(RpsType.ROCK), 0, itemsPerGroup*3, minCircleSize, maxCirclesSize);
    float paperCircleSize = map(counts.get(RpsType.PAPER), 0, itemsPerGroup*3, minCircleSize, maxCirclesSize);
    float scissorsCircleSize = map(counts.get(RpsType.SCISSORS), 0, itemsPerGroup*3, minCircleSize, maxCirclesSize);
    float xRock = width/4;
    float xPaper = width/2;
    float xScissors = 3*(width/4);
    float yShape = height*0.89;
    float yText = height*0.96;
    
    // Circles
    noStroke();
    fill(colorRock);
    ellipse(xRock, yShape, circleSize, circleSize);
    fill(colorPaper);
    ellipse(xPaper, yShape, circleSize, circleSize);
    fill(colorScissors);
    ellipse(xScissors, yShape, circleSize, circleSize);

    // Shapes
    shapeMode(CENTER);
    shape(shapes.get(RpsType.ROCK), xRock, yShape, shapeSize, shapeSize);
    shape(shapes.get(RpsType.PAPER), xPaper, yShape, shapeSize, shapeSize);
    shape(shapes.get(RpsType.SCISSORS), xScissors, yShape, shapeSize, shapeSize);

    // Texte
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    text(counts.get(RpsType.ROCK), xRock, yText);
    text(counts.get(RpsType.PAPER), xPaper, yText);
    text(counts.get(RpsType.SCISSORS), xScissors, yText);
  }

  void updateItemCount() {
    counts.put(RpsType.ROCK, 0);
    counts.put(RpsType.PAPER, 0);
    counts.put(RpsType.SCISSORS, 0);

    for (Item item : items) {
      RpsType type = item.getType();
      counts.put(type, counts.get(type) + 1);
    }
  }

  boolean doWeHaveAWinner() {
    return items.stream().map(Item::getType).distinct().count() == 1;
  }

  RpsType getWinningType() {
    if (doWeHaveAWinner() && !items.isEmpty()) {
      return items.get(0).getType(); // Alle Items haben denselben Typ → Nimm das erste
    }
    return null; // Kein Gewinner vorhanden
  }
}
