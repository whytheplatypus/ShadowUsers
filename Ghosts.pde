/*User shadows using simple-openni
 *David Gage
 */

class Ghosts{
  SimpleOpenNI context;
  
  Ghosts(SimpleOpenNI c){
    context = c;
  }

  void draw(int chosenUser){
    //int[] myScenemap = new int[context.sceneWidth() * context.sceneHeight()];
    //context.sceneMap(myScenemap);
    
    int userCount = context.getNumberOfUsers();
    int[] userMap = null;
    if(userCount > 0)
    {
      userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    }
    
    PImage theCameraSees = context.rgbImage();
    //myScenemap and theCamerasees are the same size, just making sure
    theCameraSees.loadPixels();
    if(userMap != null){
      for(int i = 0; i < userMap.length; i++){
        if(userMap[i] > 0){
          if(userMap[i] != chosenUser){
            theCameraSees.pixels[i] = color(100, 100, 100);
          }
        }
        //eventually we can add something to store the background and make the users transparent
      }
      theCameraSees.updatePixels();
      image(theCameraSees,0,0);
    } else {
      background(240,240,240);
    }
  }
}
