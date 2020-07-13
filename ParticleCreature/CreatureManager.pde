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
    //String path = sketchPath()+"/data/SVG_Amphibians/";
    String path = sketchPath()+"/data/All/";
    println("load from "+path);
    String[] filenames = listFileNames(path);
    printArray(filenames);

    int i = 0;
    int j = 0;
    for (String fileNames : filenames ) {
      //Amphibian amp = new Amphibian("SVG_Amphibians/"+fileNames);
      Amphibian amp = new Amphibian("All/"+fileNames);

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
      ((Amphibian)ampArray.get(index)).draw();
  }


  Amphibian getCreature(int index) {
    return ((Amphibian)ampArray.get(index));
  }

  //draw individual ones
  void drawCenter(int index) {
    if (index >=0  && index < ampArray.size())
      ((Amphibian)ampArray.get(index)).drawCenter();
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

  void reset() {
    for (Amphibian amp : ampArray) {
      amp.reset();
    }
  }

  //update variables
  void update() {
    for (Amphibian amp : ampArray) {
      amp.update();
    }
  }
}
