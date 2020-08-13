String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}


//values
int creatures [][] = {{0, 1, 1, 1, 1},
                      {1, 0, 1, 1, 2}, 
                      {1, 2, 0, 2, 1}, 
                      {2, 2, 1, 1, 2},
                      {2, 2, 1, 1, 0}};
