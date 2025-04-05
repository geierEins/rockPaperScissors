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
  long initialStretchFactor = 500L;
  long stretchFactor;

  DiagramManager() {
    this.stretchFactor = initialStretchFactor;
    println("stretchFactor now: " + stretchFactor);
  }

  void displayDiagrams() {
    if (!rockCountDots.isEmpty() && rockCountDots.get(rockCountDots.size()-1).x >= boxBoundaries.get("xR")-20) stretchBy(1.6); // stretch diagrams if right edge is reached
    displayItemCountDiagram(RpsType.ROCK);
    displayItemCountDiagram(RpsType.PAPER);
    displayItemCountDiagram(RpsType.SCISSORS);
  }

  void displayItemCountDiagram(RpsType type) {
    PVector currentPoint = new PVector(0, 0);

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

  void stretchBy(float f) {
    compressDiagramsByFactor(f);
    multiplyStretchFactorBy(f);
    println("stretched diagrams by " + f + " (stretchFactor now: " + this.stretchFactor + ")");
  }

  void compressDiagramsByFactor(float factor) {
    float xL = boxBoundaries.get("xL");
    for (int i=0; i<rockCountDots.size(); i++) {
      rockCountDots.get(i).x = ((rockCountDots.get(i).x-xL)/factor)+xL;
      paperCountDots.get(i).x = ((paperCountDots.get(i).x-xL)/factor)+xL;
      scissorsCountDots.get(i).x = ((scissorsCountDots.get(i).x-xL)/factor)+xL;
    }
  }

  void multiplyStretchFactorBy(float f) {
    this.stretchFactor *= f;
  }

  void setMotion(boolean b) {
    isMotion = b;
  }

  void reset() {
    rockCountDots.clear();
    paperCountDots.clear();
    scissorsCountDots.clear();
    currentXinput = 0;
    stretchFactor = initialStretchFactor;
    setMotion(true);
  }
}
