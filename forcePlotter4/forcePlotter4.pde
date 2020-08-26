import processing.serial.*;
import grafica.*;

//this is the first github edit
//this is the second github edit yay!
//now without branching

// Serial Plotter, Start Button, Stop Button, and File Name Selection
// for catheter insertion force measurement project
// Sarah Hanson
// last update: 8-25-20


// Variables, objects, etc ---------------------------------
Serial myPort;
String inBuffer; //input from teensy serial

boolean startRec = false; //for starting to record data from serial port
PrintWriter output; //for saving data file
String fileName = "";
String userInput = ""; //only in class?
boolean fileNameOver = false;
//put in fail-safe: get month-day-hour-minute for file name *****

MyText c = new MyText(200,810,25); //x position, y position, text size //825


String[] token; //for data
int xx;
float yy;

GPlot plot1; //for graph

int rect1X, rect1Y;   //position of start button
int rect2X, rect2Y;   //position of stop button
int rectSize = 120;   //size of button sides (height and width are equal)

int nameX, nameY;   //position of file-naming submit button
int nameSize = 50;  //size of file-naming submit button

color rect1Color, rect2Color, baseColor, nameColor;
color rectHighlight, rect2Highlight;
color currentColor;
boolean rectOver = false;
boolean rect2Over = false;


// Setup ----------------------------------------------------
void setup() {
  size(1100, 900);
  
  //CHECK if device is plugged in on startup
  //later check while running if device gets upplugged or plugged back in
  
  c.activate(); //825
  
  output = createWriter("fileName7.txt"); //create a new file in the sketch directory
  //get user input for file name ***
  //but also, put in fail-safe: get month-day-hour-minute for file name ***
  //call file naming func? call update()?
  
  //output = createWriter(fileName);
  
  //later get user input for directory to save file into ***
  //selectOutput("Select a file to write to: ", "fileSelected"); //edit24
  
  //printArray(Serial.list()); //temporary
  myPort = new Serial(this,Serial.list()[0],9600); //[0] is port number Teensy is using
  //myPort.bufferUntil('\n'); //could use later //a serialEvent() generated when newline found
  
  plot1 = new GPlot(this);
  plot1.setPos(200,275);
  plot1.setDim(600,350); //grafica adds 100 pixels to plot
  //other plot setup stuff here
  plot1.getTitle().setText("Catheter Insertion Force Over Time");
  plot1.getXAxis().getAxisLabel().setText("Time (ms)"); //xlabel
  plot1.getYAxis().getAxisLabel().setText("Force on Loadcell (g)"); //ylabel
  //plot1.setPointColor(color(0,0,0,255)); //***
  //plot1.setPointSize(2); //***
  
  //Colors
  //w = width/2
  //h = height/2
  rect1Color = color(0,200,50);   //green for start
  rect2Color = color(200,0,0);    //red for stop
  //(0,255,0) is green, (0,0,255) is blue, (255,0,0) is red
  rectHighlight = color(0,150,30);   //dull green
  rect2Highlight = color(150,0,0);   //dull red
  baseColor = color(100);   //gray
  currentColor = baseColor;
  nameColor = color(0,0,255);
  
  //Position of buttons
  rect1X = 200; //width/2-rectSize-60;//half rect size
  rect2X = 780; //width/2+rectSize;
  rect1Y = 100; //height/2-rectSize/2;
  rect2Y = 100; //height/2-rectSize/2;
  
  nameX = 850;
  nameY = 750;
  
  //use later? is this a better way?
  //addButton = createButton('Start');
  //addButton.size(100, 50)
  //addButton.position(w, height - 200)
  //addButton.mousePressed(doSomething)
  
}


// Draw -----------------------------------------------------
void draw() {
  update(mouseX, mouseY);
  background(currentColor);
  
  //ask for user input for file name and display it
  fill(0);
  textSize(25);
  text("Type file name (with .txt): ", 200, 775);
  //then use void keyPressed() and mousePressed() *** and update()?
  //maybe run update(mouseX, mouseY) after printing text to gui and asking for user input
  //text("fileName_hopefullyFromUser", 200, 810); //comment out for edit 825
  c.display(); //see display loop //825
  //use readString to save userInput as fileName ***
  
  
  if (rectOver) {
    fill(rectHighlight);
  }
  else {
    fill(rect1Color);
  }
  stroke(255);
  rect(rect1X, rect1Y, rectSize, rectSize);
  
  if (rect2Over) {
    fill(rect2Highlight);
  }
  else {
    fill(rect2Color);
  }
  stroke(255);
  rect(rect2X, rect2Y, rectSize, rectSize);
  
  fill(nameColor);
  stroke(255);
  rect(nameX, nameY, nameSize, nameSize);
  
  
  // Text on buttons
  fill(0);
  textSize(30);
  text("Start", rect1X + rectSize/4, rect1Y + rectSize/2);
  fill(0);
  textSize(30);
  text("Stop", rect2X + rectSize/4, rect2Y + rectSize/2);
  fill(255);
  textSize(50);
  text("o", nameX + 10, nameY + 40); //submit button for file name
  
  
  while (myPort.available() > 0)
  {
    //read string in
    inBuffer = myPort.readString();
    //did we read anything in?
    if (inBuffer != null) //if not null, then yes
    {
      //print(inBuffer); //temporary ***
      token = splitTokens(inBuffer, ","); //split string into tokens
      
      // CHOOSE WHICH LOADCELL TO TEST HERE ***************************************
      // the plot only displays force1 (force from flat-side of tongs)
      // change [1] to [2] to test/display force2
      yy = float(token[1]); //DAT1 (force1)
      xx = int(token[3]); //CLK1 (time)
      
      //xx = int(token[2]); //CLK1 for testing one loadcell *****
      //println(xx); //xx didn't work because of newline without comma delim; fixed
      //println(yy);
      
      plot1.addPoint(xx,yy);
      
      
    }
    
    if (startRec == true) {
      //output.println("try this too: " + inBuffer);
      output.println(inBuffer);
    }
    
  }
  
  plot1.beginDraw();
  plot1.drawBackground();
  plot1.drawBox();
  plot1.drawXAxis();
  plot1.drawYAxis();
  plot1.drawTitle();
  plot1.drawGridLines(GPlot.BOTH);
  plot1.drawLines(); //draw lines between points
  plot1.drawPoints();
  plot1.endDraw();
  
  
  // end draw loop
}


// Other loops ---------------------------------------------
void update(int x, int y) //need x and y here? what were they for?
{
  if (overRect2(rect2X, rect2Y, rectSize, rectSize)) {
    rect2Over = true;
    rectOver = false;
  }
  else if (overRect(rect1X, rect1Y, rectSize, rectSize)) {
    rectOver = true;
    rect2Over = false;
  }
  else {
    rect2Over = rectOver = false;
  }
  
  
  if (overFileName(nameX, nameY, nameSize, nameSize)) {
    fileNameOver = true;
  }
  else {
    fileNameOver = false;
  }
  
  
}

void keyPressed() {   //*****************************************************
  //old code; comment out for edit 825
  /*
  userInput += key;
  //if create own toString method, then: userInput = toString(userInput);
  println(userInput);
  //where is "null" from? because userInput is an object?
  */
  
  /*
  //limit to detect for alphanumeric characters
  if() {
    //something
  }
  else {
    //something
  }
  
  //add a way to clear userInput or different way to write (text box)
  */
  
  
  
  //new code //825
  
  if (keyAnalyzer(key).compareTo("LETTER") == 0 ||
      keyAnalyzer(key).compareTo("NUMBER") == 0 || 
      keyAnalyzer(key).compareTo("DASH") == 0)
  {
    c.addChar(key);
  }
  
  if (keyCode == BACKSPACE)
  {
    c.deleteChar();
  }
  
  if (key == '\n') {   //when user presses "enter" key
    //set file name to chars typed by user
    fileName = c.readString(); //userInput
    //reset chars when current chars saved as userInput
    //reset loop clears chars string
    c.reset();
    println(fileName);
  }
  

}

String keyAnalyzer(char c) //825
{
    if (c >= '0' && c <= '9')
    {
        return "NUMBER";
    }
    else if (c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z')
    {
        return "LETTER";
    }
    else if (c == '_' || c == '-') //include space char?
    {
        return "DASH";
    }
    else
    {
        return "OTHER";
    }
}

class MyText //825
{
    float x;
    float y;
    String userInput;
    int numChars;
    boolean active;
    int font;
    
    MyText(float x, float y, int font)
    {
        this.x = x;
        this.y = y;
        active = false;
        this.font = font;
        userInput = "";
        numChars = 0;
    }
    
    void display()
    {
        line(x,y,x,y+font); //draw line for what? cursor? not visible; don't need
        //stroke(255); //make line visible
        textSize(font);
        text(userInput,x,y);
    }
    
    void addChar(char c)
    {
        userInput += c;
        numChars++;
    }
    
    String readString()
    {
        return userInput;
    }
    
    boolean isActive()
    {
        return active;
    }
    
    void activate()
    {
        active = true;
    }
    
    void deactivate()
    {
        active = false;
    }
    
    void reset()
    {
        userInput = "";
    }
    
    void deleteChar()
    {
            if (numChars > 0)
            {     
                  userInput = userInput.substring(0,userInput.length()-1);
                  numChars -= 1;
            }
    }
}


void mousePressed() {
  if (rectOver) {
    currentColor = rect1Color;
    //start recording data ***
    //output.println("test: " + inBuffer); //only prints inBuffer at moment button pressed
    //set some value to true, then print inBuffer in main draw loop
    startRec = true;
    
  }
  
  if (rect2Over) {
    currentColor = rect2Color;
    //stop recording data and save to file ***
    output.flush(); //write remaining data
    output.close(); //finish making file
    
  }
  
  // *************************************************************
  
  if (fileNameOver) {   //if user clicks enter button instead of pressing enter key
    //something like this...
    fileName = userInput;
    //use readString instead *****************
    
  }
  
  
}


boolean overFileName(int x, int y, int width, int height) {
  if(mouseX >= x && mouseX <= x+width &&
     mouseY >= y && mouseY <= y+height) {
    return true;
  }
  else {
    return false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  }
  else {
    return false;
  }
}

boolean overRect2(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  }
  else {
    return false;
  }
}

//not used yet; not sure it works
void fileSelected(File selection) {   //edit24
  if (selection == null) {
    println("Window was closed or user hit cancel.");
  }
  else {
    println("User selected " + selection.getAbsolutePath());
  }
  
}
