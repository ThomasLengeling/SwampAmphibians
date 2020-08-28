class CreaturesManager {
  ArrayList<CreaturesParticle> creaArray;

  //constructor
  CreaturesManager() {
    creaArray = new ArrayList<CreaturesParticle>();
  }

  CreaturesParticle getCreature(int id) {
    return creaArray.get(id);
  }

  //add indivual ones
  void add(String name) {
    CreaturesParticle amp = new CreaturesParticle(name);
    creaArray.add(amp);
  }

  void add(CreaturesParticle amp ) {
    creaArray.add(amp);
  }

  int numCreatures() {
    return creaArray.size();
  }
  
  void clear(){
    creaArray.clear();
  }

  //load all the amphibians
  void loadAll(String fileName, float sx, float sy, float sz) {
    //String path = sketchPath()+"/data/SVG_Amphibians/";
    String path = dataPath("")+"/"+fileName+"/";
    println("load from "+path);
    println("dataPath: "+dataPath(""));
    String[] filenames = listFileNames(path);
    printArray(filenames);

    int i = 0;
    for (String fileNames : filenames ) {
      CreaturesParticle amp = new CreaturesParticle(fileName+"/"+fileNames);

      amp.creature.setScale(sx, sy, sz);
      amp.creature.createCreature();

      amp.creature.setId(i);
      amp.creature.idName(fileNames);

      creaArray.add(amp);
      i++;
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
