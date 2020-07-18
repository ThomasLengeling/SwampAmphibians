class CreaturesManager {
  ArrayList<CreaturesParticle> creaArray;

  //constructor
  CreaturesManager(String fileName, float sx, float sy, float sz) {
    creaArray = new ArrayList<CreaturesParticle>();

    loadAll(fileName, sx, sy, sz);
  }

  //add indivual ones
  void add(String name) {
    CreaturesParticle amp = new CreaturesParticle(name);
    creaArray.add(amp);
  }

  int numCreatures() {
    return creaArray.size();
  }

  //load all the amphibians
  void loadAll(String fileName, float sx, float sy, float sz) {
    //String path = sketchPath()+"/data/SVG_Amphibians/";
    String path = sketchPath()+"/data/"+fileName+"/";
    println("load from "+path);
    String[] filenames = listFileNames(path);
    printArray(filenames);

    int i = 0;
    int j = 0;
    for (String fileNames : filenames ) {
      //Amphibian amp = new Amphibian("SVG_Amphibians/"+fileNames);
      CreaturesParticle amp = new CreaturesParticle(fileName+"/"+fileNames);

      amp.creature.setScale(sx, sy, sz);
      amp.creature.createCreature();

      amp.creature.setId(i);
      amp.creature.idName(fileNames);

      creaArray.add(amp);
      i++;
      if (i >= 5) {
        j++;
        i=0;
      }
    }

    println(creaArray.size());
  }

  void updateScale(float sx, float sy, float sz) {
    for (CreaturesParticle amp : creaArray) {
      amp.creature.setScale(sx, sy, sz);
    }
  }

  //draw individual ones
  void draw(int index) {
    if (index >=0  && index < creaArray.size())
      ((CreaturesParticle)creaArray.get(index)).draw();
  }


  void update(int index) {
    // if (index >=0  && index < creaArray.size())
    //((CreaturesParticle)creaArray.get(index)).update();
  }

  //draw all the amphibians
  void draw() {
    for (CreaturesParticle amp : creaArray) {
      amp.draw();
    }
  }

  //update variables
  void update() {
  }
}
