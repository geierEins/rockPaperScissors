class Slider {

  float slider_diameter = 100;
  float line_width = width/3;
  PVector slider_pos;
  PVector circle_pos;
  boolean over = false;
  boolean locked = false;
  int value;
  int minValue, maxValue;
  color strokeColor = color(50);
  color sliderColorNormal = color(200);
  color sliderColorOver = color(190);

  Slider(float x, float y, int minValue, int maxValue) {
    this.slider_pos = new PVector(x, y);
    this.circle_pos = new PVector(x, y);
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = (maxValue + minValue)/2;
    
  }
  
  Slider(float x, float y, int minValue, int maxValue, color colorNormal){
    this(x, y, minValue, maxValue);
    this.sliderColorNormal = colorNormal;
  }
  

  void showSlider() {
    strokeWeight(5);
    stroke(strokeColor);

    // Line
    line(slider_pos.x-(line_width/2), slider_pos.y, slider_pos.x+(line_width/2), slider_pos.y);

    // Circle
    if (isMouseOver()) {
      fill(sliderColorOver);
    } else {
      fill(sliderColorNormal);
    }
    ellipse(circle_pos.x, circle_pos.y, slider_diameter, slider_diameter);

    // Text
    fill(strokeColor);
    textSize(slider_diameter*0.6);
    textAlign(CENTER, CENTER);
    text(value, circle_pos.x, circle_pos.y);
  }

  void moveSlider(float x) {
    float leftX = slider_pos.x - (line_width/2);
    float rightX = slider_pos.x + (line_width/2);

    if (isMouseOver() && mouseX > leftX && mouseX < rightX) {
      this.circle_pos.x = x;
      this.value = (int)map(this.circle_pos.x, leftX, rightX, minValue, maxValue+1);
    }
  }

  boolean isMouseOver() {
    return dist(circle_pos.x, circle_pos.y, mouseX, mouseY) <= slider_diameter/2;
  }
}
