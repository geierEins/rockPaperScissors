class Button {

  PVector pos;
  float buttonWidth = 200;
  float buttonHeight = 100;
  color strokeColor = color(50);
  color buttonColorNormal = color(200);
  color buttonColorOver = color(190,240,190);
  String buttonText;

  Button(float x, float y, String buttonText) {
    this.pos = new PVector(x, y);
    this.buttonText = buttonText;
  }

  void showButton() {
    rectMode(CENTER);
    strokeWeight(5);
    
    // rect
    if (isMouseOver()) {
      fill(buttonColorOver);
    } else {
      fill(buttonColorNormal);
    }
    rect(pos.x, pos.y, buttonWidth, buttonHeight, 20);
    
    // text
    fill(strokeColor);
    textSize(buttonHeight*0.5);
    textAlign(CENTER, CENTER);
    text(buttonText, pos.x, pos.y);
  }

  boolean isMouseOver() {
    float leftEdge = pos.x - (buttonWidth/2);
    float rightEdge = pos.x + (buttonWidth/2);
    float upperEdge = pos.y - (buttonHeight/2);
    float bottomEdge = pos.y + (buttonHeight/2);
    return (mouseX>leftEdge && mouseX<rightEdge && mouseY>upperEdge && mouseY<bottomEdge );
  }
}
