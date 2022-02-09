ABBCom com;
int port = 0; //port number the robot is connected to
Pose target1 = new Pose(new PVector(130,-56,-36),new Quaternion(0.6,-0.5,-0.4,-0.3));
Pose target2 = new Pose(new PVector(0,0,200),new Quaternion(0,-1,0,0));


void setup() {
  com = new ABBCom();
  com.startSerial(this, port);
} //end setup()

void draw() {
} //end draw()

void mousePressed() {
  if (mousePressed && (mouseButton == LEFT)) {
    //com.writeTP("I am a robot");
    com.moveL(target1);
  } else if (mousePressed && (mouseButton == RIGHT)) {
    com.moveL(target2);
  } else if (mousePressed && (mouseButton == CENTER)) {
    com.close();
  }
} //end mousePressed()
