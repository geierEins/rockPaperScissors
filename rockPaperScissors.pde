import java.util.Map;
import java.util.stream.IntStream;
import java.util.stream.Collectors;
import java.util.List;

RpsManager rpsManager;
CountManager countManager;
ResultPanel resultPanel;
DiagramManager diagramManager;

List<Item> items = new ArrayList<>();

int itemsPerGroup = 1;

Map<String, Float> boxBoundaries = new HashMap<>();
Map<RpsType, PShape> shapes = new HashMap<>();
Map<RpsType, Integer> counts = new HashMap<>(Map.of(RpsType.ROCK, itemsPerGroup, RpsType.PAPER, itemsPerGroup, RpsType.SCISSORS, itemsPerGroup));

color colorRock = color(178, 200, 250);
color colorPaper = color(230, 255, 170);
color colorScissors = color(255, 170, 170);

int velLimit = 10;
int itemSize = 20;

void setup() {
  size(1800, 900);
  initBoxBoundaries();
  frameRate(60);
  loadShapes();
  rpsManager = new RpsManager();
  countManager = new CountManager();
  resultPanel = new ResultPanel();
  diagramManager = new DiagramManager();
}

void draw() {
  background(155);
  if (!countManager.doWeHaveAWinner()) {
    countManager.run();
    rpsManager.run();
  } else {
    countManager.run();
    rpsManager.stop();
    diagramManager.stopMotion();
    diagramManager.displayDiagrams();
    resultPanel.showResults();
  }
}

void loadShapes() {
  shapes.put(RpsType.ROCK, loadShape("rock.svg"));
  shapes.put(RpsType.PAPER, loadShape("paper.svg"));
  shapes.put(RpsType.SCISSORS, loadShape("scissors.svg"));
}

void initBoxBoundaries() {
  float margin = 15f;
  boxBoundaries = new HashMap<>(Map.of(
    "xL", margin, "xR", (float) width-margin, "yO", margin, "yU", height*0.85
    ));
}

void keyPressed() {
  if (key == 'R' || key == 'r') reset();
  if (key == 'D' || key == 'd') delay(100000);
  if (key == 's' || key == 'S') diagramManager.compressDiagramsByFactor(2);
}

void mousePressed() {
  if (countManager.doWeHaveAWinner()) reset();
}

void reset() {
  counts = new HashMap<>(Map.of(RpsType.ROCK, itemsPerGroup, RpsType.PAPER, itemsPerGroup, RpsType.SCISSORS, itemsPerGroup));
  rpsManager.initItems();
  diagramManager.reset();
}
