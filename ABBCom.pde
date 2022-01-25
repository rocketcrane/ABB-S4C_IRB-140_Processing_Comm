import processing.serial.*;

class ABBCom {
  Serial myPort;
  
  void startSerial(PApplet theSketch, int portIndex) {
    Serial tempPort;
    println("Available Ports: ");
    printArray(Serial.list());
    if(Serial.list().length <= portIndex) {
      println("Invalid port index");
      System.exit(-1);
    }
    String portName = Serial.list()[portIndex];
    tempPort = new Serial(theSketch, portName, 9600);
    myPort = tempPort;
    println("Attempted to connect to robot at port", portIndex);
  } //end function startSerial()
  
  void writeTP(String input) {
    String msg = "88 " + input + " #\n";
    myPort.write(msg);
    println("Attempted writing to teach pendant:", msg);
  } //end function writeTP()
  
  void close() {
    String msg = "99 #\n";
    myPort.write(msg);
    String response = myPort.readStringUntil(10); //ASCII linefeed
    println(response);
    myPort.stop();
    println("Attempted disconnection from ABB robot, message:", msg);
    exit();
  } //end function close()
} //end class ABBCom
