ABBCom com;
int port = 0; //port number the robot is connected to

void setup() {
  com = new ABBCom();
  com.startSerial(this, port);
} //end setup()

void draw() {
} //end draw()

void mousePressed() {
  if (mousePressed && (mouseButton == LEFT)) {
    com.writeTP("Hello World");
    com.readMsg();
  } else if (mousePressed && (mouseButton == RIGHT)) {
    com.close();
  } else {
    
  }
} //end mousePressed()
