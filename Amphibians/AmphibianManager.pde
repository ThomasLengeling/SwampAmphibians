class AmphibianManager {
  ArrayList<Amphibian> ampArray;

  //constructor
  AmphibianManager() {
    ampArray = new ArrayList<Amphibian>();
  }

  //add indivual ones
  void add(String name) {
    Amphibian amp = new Amphibian(name);
    ampArray.add(amp);
  }

  //load all the amphibians
  void loadAll() {
    String path = sketchPath()+"/data/SVG_Amphibians/";
    println("load from "+path);
    String[] filenames = listFileNames(path);
    printArray(filenames);

    int i = 0;
    for (String fileNames : filenames ) {
      Amphibian amp = new Amphibian("SVG_Amphibians/"+fileNames);
      
      float x = 
      
      amp.setId(i);
      amp.idName(fileNames);
      amp.setPos(posx, posy);
      amp.setScale(sx, sy);
      
      ampArray.add(amp);
      i++;
    }

    println(ampArray.size());
  }

  //draw individual ones
  void draw(int index) {
    if (index >=0  && index < ampArray.size())
      ((Amphibian)ampArray.get(index)).draw();
  }

  void update(int index) {
    if (index >=0  && index < ampArray.size())
      ((Amphibian)ampArray.get(index)).update();
  }

  //draw all the amphibians
  void draw() {
    for (Amphibian amp : ampArray) {
      amp.draw();
    }
  }

  //update variables
  void update() {
    for (Amphibian amp : ampArray) {
      amp.update();
    }
  }
}
