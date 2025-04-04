class RpsManager {
  RpsManager() {
    initItems();
  }

  void initItems() {
    items.clear();
    createItems(RpsType.ROCK, counts.get(RpsType.ROCK), velLimit);
    createItems(RpsType.PAPER, counts.get(RpsType.PAPER), velLimit);
    createItems(RpsType.SCISSORS, counts.get(RpsType.SCISSORS), velLimit);
  }

  void createItems(RpsType type, int count, int velLimit) {
    for (int i = 0; i < count; i++) {
      PVector position;
      do {
        position = new PVector(random(width), random(height));
      } while (!isValidStartPosition(position));

      PVector velocity = new PVector(random(-velLimit, velLimit), random(-velLimit, velLimit));
      items.add(new Item(type, position, velocity));
    }
  }

  boolean isValidStartPosition(PVector position) {
    for (Item item : items) {
      float distance = position.dist(item.pos);
      if (distance < 2 * item.r) {
        return false;
      }
    }
    return true;
  }

  void runItems() {
    IntStream.range(0, items.size()).forEach(i -> {
      Item item = items.get(i);
      item.move();
      item.checkCollisionWithBorder();

      IntStream.range(i + 1, items.size())
        .forEach(j -> item.checkCollisionWithAnotherItem(items.get(j)));

      item.display();
    }
    );
  }

  void stop() {
    items.stream().forEach(i -> i.vel.setMag(0)); // vel vektor auf 0
  }

  void drawBoxBackground() {
    rectMode(CORNER);
    float x = boxBoundaries.get("xL");
    float y = boxBoundaries.get("yO");
    float w = boxBoundaries.get("xR") - x;
    float h = boxBoundaries.get("yU") - y;
    noStroke();
    fill(255);
    rect(x, y, w, h, 10);
  }

  void drawBoxEdges() {
    rectMode(CORNER);
    float x = boxBoundaries.get("xL");
    float y = boxBoundaries.get("yO");
    float w = boxBoundaries.get("xR") - x;
    float h = boxBoundaries.get("yU") - y;
    strokeWeight(8);
    stroke(50);
    noFill();
    rect(x, y, w, h, 10);
  }
}
