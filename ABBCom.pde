import processing.serial.*;

//MESSAGE FORMAT: "xx [message] #\n"
//xx = two-digit integer
class ABBCom {
  Serial myPort;
  
  void startSerial(PApplet theSketch, int portIndex) {
    Serial tempPort;
    println("Available Ports: ");
    printArray(Serial.list());
    if(Serial.list().length <= portIndex) {
      println("Invalid port index, exiting program...");
      System.exit(-1);
    }
    String portName = Serial.list()[portIndex];
    tempPort = new Serial(theSketch, portName, 9600, 'N', 8, 1.0);
    myPort = tempPort;
    println("Attempted to connect to robot at port", portIndex);
  } //end function startSerial()
  
  void writeTP(String input) {
    String msg = "88 " + input + " #\n";
    myPort.write(msg);
    println("Attempted writing to teach pendant, message:", msg);
    readMsg();
  } //end function writeTP()
  
  void readMsg() {
    String response = myPort.readStringUntil('\n');
    println("Message from robot:", response);
  } //end function readMsg()
  
  void close() {
    String msg = "99 #\n";
    myPort.write(msg);
    readMsg();
    myPort.stop();
    println("Attempted disconnection from ABB robot, message:", msg);
    exit();
  } //end function close()
} //end class ABBCom
