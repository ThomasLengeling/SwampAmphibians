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
int creatures [][] = {{6, 6, 2, 2, 6}, 
                      {0, 0, 4, 4, 6}, 
                      {2, 2, 4, 0, 2}, 
                      {2, 2, 1, 0, 2},
                      {0, 0, 3, 2, 4},
                      {3, 3, 2, 0, 3},
                      {0, 0, 3, 0, 3},
                      {2, 2, 2, 0, 3},
                      {3, 0, 3, 0, 3},
                      {0, 3, 3, 0, 3}};
