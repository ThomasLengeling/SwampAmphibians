class CreaturesManager {
  ArrayList<Creatures> ampArray;

  //constructor
  CreaturesManager() {
    ampArray = new ArrayList<Creatures>();
  }

  //add indivual ones
  void add(String name) {
    Creatures amp = new Creatures(name);
    ampArray.add(amp);
  }

  //load all the amphibians
  void loadAll() {
    //String path = sketchPath()+"/data/SVG_Amphibians/";
    String path = sketchPath()+"/data/All/";
    println("load from "+path);
    String[] filenames = listFileNames(path);
    printArray(filenames);

    int i = 0;
    int j = 0;
    for (String fileNames : filenames ) {
      //Amphibian amp = new Amphibian("SVG_Amphibians/"+fileNames);
      Creatures amp = new Creatures("All/"+fileNames);

      float posx = i * 200 + 100;
      float posy = j * 200 + 100;
      float sx = 0.25;
      float sy = 0.25;

      amp.setId(i);
      amp.idName(fileNames);
      amp.setPos(posx, posy);
      amp.setScale(sx, sy);

      ampArray.add(amp);
      i++;
      if (i >= 5) {
        j++;
        i=0;
      }
      
    }

    println(ampArray.size());
  }

  //draw individual ones
  void draw(int index) {
    if (index >=0  && index < ampArray.size())
      ((Creatures)ampArray.get(index)).draw();
  }
  
    //draw individual ones
  void drawCenter(int index) {
    if (index >=0  && index < ampArray.size())
      ((Creatures)ampArray.get(index)).drawCenter();
  }

  void update(int index) {
    if (index >=0  && index < ampArray.size())
      ((Creatures)ampArray.get(index)).update();
  }

  //draw all the amphibians
  void draw() {
    for (Creatures amp : ampArray) {
      amp.draw();
    }
  }

  //update variables
  void update() {
    for (Creatures amp : ampArray) {
      amp.update();
    }
  }
}
