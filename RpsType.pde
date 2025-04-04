enum RpsType {
  ROCK("Rock"),
    SCISSORS("Scissors"),
    PAPER("Paper");

  private final String name;

  RpsType(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }
}
