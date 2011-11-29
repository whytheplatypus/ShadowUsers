/*User shadows using simple-openni
 *David Gage
 */
import SimpleOpenNI.*;


SimpleOpenNI context;

AloneInTheCroud aloneInTheCroud;
InvisibleMan invisibleMan;
int chosenUser = 0;

int selectedView = 0;

IntVector aUsers;

void setup()
{
  context = new SimpleOpenNI(this);
  // enable mirror
  context.setMirror(true);
  
  
  context.enableDepth();
  //we only really care where the users pixels are, so use scene
  //context.enableScene();
  // enable rgbImage generation
  context.enableRGB();
  
  // enable skeleton generation for NO joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_NONE);
  
  context.alternativeViewPointDepthToImage();
  
  
  size(context.rgbWidth() , context.rgbHeight());

  aUsers = new IntVector(); 
  aloneInTheCroud = new AloneInTheCroud(context);
  
  invisibleMan = new InvisibleMan(context);
  
}

void draw()
{
  //background(255,255,255);
  // update the cam
  context.update();
  switch(selectedView){
    case 0:
      aloneInTheCroud.draw(chosenUser);
      break;
    case 1:
      invisibleMan.draw(chosenUser);
      break;
  }
  
}

void chooseUser(){
  int userCount = context.getNumberOfUsers();
  if(userCount > 0){
    context.getUsers(aUsers);
    chosenUser = aUsers.get(int(random(userCount)));
  } else {
    chosenUser = 0;
  }
  println("choosing user: " + chosenUser);
}

// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId)
{
  if(chosenUser == 0){
    chooseUser();
  }
  println("onNewUser - userId: " + userId); 
}

void onLostUser(int userId)
{
  if(userId == chosenUser){
    chooseUser();
  }
  println("onLostUser - userId: " + userId);
}


// -----------------------------------------------------------------
// Keyboard events

void keyPressed()
{
  //switch between views
  if(key == 'n'){
    chooseUser();
  } else {
    selectedView = (selectedView+1)%2;
    println("switching to view "+selectedView);
  }
}
