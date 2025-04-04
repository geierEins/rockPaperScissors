class Item {

  RpsType type;
  PVector pos, vel;
  int r;
  color textColor = color(255);
  PShape shape;

  Item(RpsType type, PVector pos, PVector vel) {
    this.type = type;
    this.pos = pos;
    this.vel = vel;
    this.r = itemSize;
  }

  void display() {
    applyColorByType();
    drawCircle();
    //drawText();
    drawShape();
  }

  void drawCircle() {
    ellipse(pos.x, pos.y, r*2, r*2);
  }

  void drawText() {
    textAlign(CENTER, CENTER);
    fill(textColor);
    textSize(20);
    text(type.getName().charAt(0), pos.x, pos.y);
  }

  void drawShape() {
    switch(this.type) {
    case ROCK :
      shape = shapes.get(RpsType.ROCK);
      break;
    case PAPER :
      shape = shapes.get(RpsType.PAPER);
      break;
    case SCISSORS :
      shape = shapes.get(RpsType.SCISSORS);
      break;
    }
    shape(shape, this.pos.x, this.pos.y, 1.6*this.r, 1.6*this.r);
  }

  void applyColorByType() {
    noStroke();
    int alpha = 150;
    switch(type) {
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
  }

  void move() {
    pos.x+=vel.x;
    pos.y+=vel.y;
  }

  void checkCollisionWithBorder() {
    float xL = boxBoundaries.get("xL");
    float xR = boxBoundaries.get("xR");
    float yO = boxBoundaries.get("yO");
    float yU = boxBoundaries.get("yU");

    if (pos.x - r <= xL) {
      pos.x = xL + r;
      vel.x *= -1;
    } else if (pos.x + r >= xR) {
      pos.x = xR - r;
      vel.x *= -1;
    }

    if (pos.y - r <= yO) {
      pos.y = yO + r;
      vel.y *= -1;
    } else if (pos.y + r >= yU) {
      pos.y = yU - r;
      vel.y *= -1;
    }
  }

  void checkCollisionWithAnotherItem(Item anotherItem) {
    float distance = this.pos.dist(anotherItem.pos);
    float minDistance = this.r + anotherItem.r;

    if (distance <= minDistance) {
      // Vektor von Mittelpunkt zu Mittelpunkt berechnen
      PVector d = PVector.sub(anotherItem.pos, this.pos);

      // Normale berechnen
      PVector n = d.copy().normalize();

      // Projektion der Geschwindigkeiten v1 und v2 auf n (v*n)*n
      float v1_DOT_n = this.vel.dot(n);
      float v2_DOT_n = anotherItem.vel.dot(n);

      // projN_v1 und projN_v2 berechnen
      PVector projN_v1 = PVector.mult(n, v1_DOT_n);
      PVector projN_v2 = PVector.mult(n, v2_DOT_n);

      // Normalkomponenten vertauschen
      PVector v1_res = (this.vel.sub(projN_v1)).add(projN_v2);
      PVector v2_res = (anotherItem.vel.sub(projN_v2)).add(projN_v1);

      this.vel = v1_res;
      anotherItem.vel = v2_res;

      // Neue Positionskorrektur, um Überlappung zu vermeiden**
      float overlap = minDistance - distance;
      PVector correction = PVector.mult(n, overlap / 2);

      this.pos.sub(correction);   // Bewege dieses Item zurück
      anotherItem.pos.add(correction); // Bewege das andere Item zurück

      // Ändern des Typs basierend auf den Kollisionsergebnissen
      if (this.beats(anotherItem.type)) {
        anotherItem.type = this.type;
      } else if (anotherItem.beats(this.type)) {
        this.type = anotherItem.type;
      }
    }
  }

  boolean beats(RpsType other) {
    return (this.type == RpsType.ROCK && other == RpsType.SCISSORS) ||
      (this.type == RpsType.SCISSORS && other == RpsType.PAPER) ||
      (this.type == RpsType.PAPER && other == RpsType.ROCK);
  }

  RpsType getType() {
    return type;
  }
}
