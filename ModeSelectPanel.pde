class ModeSelectPanel {

  Slider sliderItemsPerGroup, sliderItemSize, sliderVelLimit;
  Button goButton;

  float text1_Y = 0.2 * height;
  float slider1_Y = 0.28 * height;
  float text2_Y = 0.4 * height;
  float slider2_Y = 0.48 * height;
  float text3_Y = 0.6 * height;
  float slider3_Y = 0.68 * height;
  float goButton_Y = 0.83 * height;

  float centralX = width/2;
  float centralY = height/2;

  int itemsPerGroup;

  ModeSelectPanel() {
    sliderItemsPerGroup = new Slider(centralX, slider1_Y, 1, 60, color(255, 153, 153));
    sliderItemSize = new Slider(centralX, slider2_Y, 5, 80, color(153, 204, 255));
    sliderVelLimit = new Slider(centralX, slider3_Y, 3, 18, color(255, 229, 204));
    goButton = new Button(centralX, goButton_Y, "GO!");
  }

  void show() {
    showFrame();
    showText("Anzahl Items Pro Gruppe:", centralX, text1_Y);
    sliderItemsPerGroup.showSlider();
    showText("Item-Größe:", centralX, text2_Y);
    sliderItemSize.showSlider();
    showText("Speed Limit:", centralX, text3_Y);
    sliderVelLimit.showSlider();
    goButton.showButton();
  }

  void showText(String text, float x, float y) {
    fill(50);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(text, x, y);
  }
  
  void showFrame(){
    rectMode(CENTER);
    stroke(50);
    fill(230);
    rect(centralX, centralY, width/2, height*0.85, 20);
  }
}
