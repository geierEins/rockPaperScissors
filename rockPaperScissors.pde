import java.util.Map;
import java.util.stream.IntStream;
import java.util.stream.Collectors;
import java.util.List;

RpsManager rpsManager;
CountManager countManager;
DiagramManager diagramManager;
ResultPanel resultPanel;
ModeSelectPanel modeSelectPanel;

List<Item> items = new ArrayList<>();

// 50.10.10, 30.15.10,
int itemsPerGroup;
int itemSize;
int velLimit = 10;

int screen = 0;

Map<String, Float> boxBoundaries = new HashMap<>();
Map<RpsType, PShape> shapes = new HashMap<>();
Map<RpsType, Integer> counts;

color colorRock = color(178, 200, 250);
color colorPaper = color(205, 190, 112);
color colorScissors = color(230, 170, 170);

void setup() {
  size(1700, 900);
  frameRate(60);
  modeSelectPanel = new ModeSelectPanel();
}

void draw() {
  background(155);

  switch(screen) {
  case 0 : // mode select
    modeSelectPanel.show();
    break;

  case 1 : // run simulation
    runThis();
    if (countManager.doWeHaveAWinner()) {
      rpsManager.stop();
      diagramManager.setMotion(false);
      resultPanel.showResults();
    }
    break;
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
    "xL", margin, "xR", (float) width-margin, "yO", margin, "yU", height*0.81
    ));
}

void printPreset() {
  println("---");
  println("itemsPerGroup: " + itemsPerGroup + ", itemSize: " + itemSize + ", velLimit: " + velLimit);
  println("---");
}

void initGame(int ipg, int is, int vel){
  itemsPerGroup = ipg;
  itemSize = is;
  velLimit = vel;
  
  counts = new HashMap<>(Map.of(RpsType.ROCK, itemsPerGroup, RpsType.PAPER, itemsPerGroup, RpsType.SCISSORS, itemsPerGroup));
  printPreset();
  initBoxBoundaries();
  loadShapes();

  rpsManager = new RpsManager();
  countManager = new CountManager();
  diagramManager = new DiagramManager();

  resultPanel = new ResultPanel();
}

void reset() {
  diagramManager.reset();
  resultPanel.reset();
  rpsManager.stop();
  screen = 0;   
}

void keyPressed() {
  if (key == 'R' || key == 'r') reset();
  if (key == 's' || key == 'S') diagramManager.stretchBy(2);
  if (key == 'D' || key == 'd') diagramManager.stretchBy(0.5);
  if (key == 'h' || key == 'H') resultPanel.switchShowOnOff();
}

void mousePressed() {
  if (screen == 0 && modeSelectPanel.goButton.isMouseOver()) {
    initGame(modeSelectPanel.sliderItemsPerGroup.value,modeSelectPanel.sliderItemSize.value,velLimit);
    screen = 1;
  } 
  if (screen == 1 && countManager.doWeHaveAWinner()) reset();
}

void mouseDragged() {
  if (screen == 0) {
    modeSelectPanel.sliderItemSize.moveSlider(mouseX);
    modeSelectPanel.sliderItemsPerGroup.moveSlider(mouseX);
  }
}
