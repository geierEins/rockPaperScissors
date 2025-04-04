class DiagramManager {
  List<PVector> rockCountDots = new ArrayList<>();
  List<PVector> paperCountDots = new ArrayList<>();
  List<PVector> scissorsCountDots = new ArrayList<>();

  float maxY = boxBoundaries.get("yO");
  float maxX = boxBoundaries.get("xR");
  float minY = boxBoundaries.get("yU");
  float minX = boxBoundaries.get("xL");

  float currentXinput = 0f;
  boolean isMotion = true;

  void displayDiagrams() {
    displayItemCountDiagram(RpsType.ROCK);
    displayItemCountDiagram(RpsType.PAPER);
    displayItemCountDiagram(RpsType.SCISSORS);
  }

  void displayItemCountDiagram(RpsType type) {
    PVector currentPoint = new PVector(0, 0);
    int stretchFactor = 1000;
    
    currentPoint.x = map(currentXinput, 0, stretchFactor, minX, maxX);
    currentPoint.y = map(counts.get(type), 0, itemsPerGroup*3, minY, maxY);

    strokeWeight(3);

    List<PVector> currentList = new ArrayList<>();

    switch(type) {
    case ROCK :
      currentList = rockCountDots;
      stroke(colorRock);
      break;
    case PAPER :
      currentList = paperCountDots;
      stroke(colorPaper);
      break;
    case SCISSORS :
      currentList = scissorsCountDots;
      stroke(colorScissors);
      break;
    }

    currentList.add(currentPoint);

    for (int i=1; i<currentList.size(); i++) {
      PVector thisP = currentList.get(i);
      PVector lastP = currentList.get(i-1);
      line(thisP.x, thisP.y, lastP.x, lastP.y);
    }

    if (isMotion) currentXinput+=1;
  }

  void compressDiagramsByFactor(int factor) {
    for (int i=1; i<rockCountDots.size(); i++) {
      rockCountDots.get(i).x /= factor;
      paperCountDots.get(i).x /= factor;
      scissorsCountDots.get(i).x /= factor;
    }
  }

  void stopMotion() {
    isMotion = false;
  }

  void reset() {
    rockCountDots.clear();
    paperCountDots.clear();
    scissorsCountDots.clear();
    currentXinput = 0;
  }
}
