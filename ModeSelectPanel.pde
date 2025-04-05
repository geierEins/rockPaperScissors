class ModeSelectPanel {

  Slider sliderItemsPerGroup, sliderItemSize;
  Button goButton;
  
  float text1_Y = 0.2 * height;
  float slider1_Y = 0.3 * height;
  float text2_Y = 0.5 * height;
  float slider2_Y = 0.6 * height;
  float goButton_Y = 0.8 * height;

  float centralX = width/2;
  float centralY = height/2*1.05;

  int itemsPerGroup;

  ModeSelectPanel() {
    sliderItemsPerGroup = new Slider(centralX, slider1_Y, 1, 60);
    sliderItemSize = new Slider(centralX, slider2_Y, 5, 80);
    goButton = new Button(centralX, goButton_Y, "GO!");
  }

  void show() {
    showFrame();
    showText("itemsPerGroup:", centralX, text1_Y);
    sliderItemsPerGroup.showSlider();
    showText("itemSize:", centralX, text2_Y);
    sliderItemSize.showSlider();
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
    rect(centralX, centralY, width/2, height*0.8, 20);
  }
}
