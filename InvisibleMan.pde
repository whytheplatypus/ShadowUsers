/*User shadows using simple-openni
 *David Gage
 */

class InvisibleMan{
  
  SimpleOpenNI context;
  PImage lastImage;
  
  InvisibleMan(SimpleOpenNI c){
    context = c;
    lastImage = new PImage(context.rgbWidth(), context.rgbWidth());
  }
  

  void draw(int chosenUser){
    
    int userCount = context.getNumberOfUsers();
    int[] userMap = null;
    if(userCount > 0)
    {
      userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    }
    
    //int[] myScenemap = new int[context.sceneWidth() * context.sceneHeight()];
    //context.sceneMap(myScenemap);
    PImage theCameraSees = context.rgbImage();
    //myScenemap and theCamerasees are the same size, just making sure
    theCameraSees.loadPixels();
    lastImage.loadPixels();
    if(userMap != null){
      for(int i = 0; i < userMap.length; i++){
        if(userMap[i] == chosenUser){
          if(i > 10 && i < userMap.length-11){
            for(int k = i-10; k < i+10; k++){
              theCameraSees.pixels[k] = lastImage.pixels[k];
            }
          } else {
            theCameraSees.pixels[i] = lastImage.pixels[i];
          }
        }
        lastImage.pixels[i] = theCameraSees.pixels[i];
      }
    }
    lastImage.updatePixels();
    theCameraSees.updatePixels();
  
  
  
    image(theCameraSees,0,0);
  }
}

