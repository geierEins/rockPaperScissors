import java.util.Map;
import java.util.stream.IntStream;
import java.util.stream.Collectors;
import java.util.List;

RpsManager rpsManager;
CountManager countManager;
ResultPanel resultPanel;
DiagramManager diagramManager;

List<Item> items = new ArrayList<>();

// 50.10.10, 30.15.10, 
int itemsPerGroup = 30;
int itemSize = 15;
int velLimit = 10;

Map<String, Float> boxBoundaries = new HashMap<>();
Map<RpsType, PShape> shapes = new HashMap<>();
Map<RpsType, Integer> counts = new HashMap<>(Map.of(RpsType.ROCK, itemsPerGroup, RpsType.PAPER, itemsPerGroup, RpsType.SCISSORS, itemsPerGroup));

color colorRock = color(178, 200, 250);
color colorPaper = color(205, 190, 112);
color colorScissors = color(230, 170, 170);
//color colorScissors = color(255, 170, 170);

void setup() {
  size(1800, 900);
  frameRate(60);
  printPreset();
  initBoxBoundaries();
  loadShapes();
  rpsManager = new RpsManager();
  countManager = new CountManager();
  resultPanel = new ResultPanel();
  diagramManager = new DiagramManager();
}

void draw() {
  background(155);
  runThis();

  if (countManager.doWeHaveAWinner()) {
    rpsManager.stop();
    diagramManager.setMotion(false);
    resultPanel.showResults();
  }
}

void runThis() {
  countManager.run();
  rpsManager.drawBoxBackground();
  diagramManager.displayDiagrams();
  rpsManager.runItems();
  rpsManager.drawBoxEdges();
}

void loadShapes() {
  shapes.put(RpsType.ROCK, loadShape("rock.svg"));
  shapes.put(RpsType.PAPER, loadShape("paper.svg"));
  shapes.put(RpsType.SCISSORS, loadShape("scissors.svg"));
}

void initBoxBoundaries() {
  float margin = 15f;
  boxBoundaries = new HashMap<>(Map.of(
    "xL", margin, "xR", (float) width-margin, "yO", margin, "yU", height*0.83
    ));
}

void printPreset() {
  println("---");
  println("itemsPerGroup: " + itemsPerGroup + ", itemSize: " + itemSize + ", velLimit: " + velLimit);
  println("---");
}

void keyPressed() {
  if (key == 'R' || key == 'r') reset();
  if (key == 'D' || key == 'd') delay(100000);
  if (key == 's' || key == 'S') diagramManager.stretchBy(2);
}

void mousePressed() {
  if (countManager.doWeHaveAWinner()) reset();
}

void reset() {
  counts = new HashMap<>(Map.of(RpsType.ROCK, itemsPerGroup, RpsType.PAPER, itemsPerGroup, RpsType.SCISSORS, itemsPerGroup));
  rpsManager.initItems();
  diagramManager.reset();
}
