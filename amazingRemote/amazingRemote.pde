//https://docs.google.com/Doc?docid=0ASu71eTOMQ9zZDl3a3J4N182MmY0YzJtc2Nj&hl=en&pli=1
//http://tiredjuan.wordpress.com/2011/06/23/16switch/
// if you want the serial for led debug
// 0 -> 1288 bytes 
// 1 -> 3090 bytes
#define LED_DEBUG_SERIAL 1

// led pin def
#define LED_BLUE  9
#define LED_RED   10
#define LED_GREEN  11
#define LED_WHITE  6
#define BALL_BUTTON  12

// direction pin def
#define DIR_UP    3
#define DIR_DOWN  2

// "how sensitive" is the color change to the trackball motion
#define VERT_INC  5

// set pin numbers:
const int switchPin1 = A1;     // the number of the switch’s pin 1
const int switchPin2 = A2;     // the number of the switch’s pin 2
const int switchPin3 = A3;     // the number of the switch’s pin 4
const int switchPin4 = A4;     // the number of the switch’s pin 8


//BUTTONS
const int buttonPin1 = 4;     // the number of the switch’s pin 1
const int buttonPin2 = 5;     // the number of the switch’s pin 2
const int buttonPin3 = 7;     // the number of the switch’s pin 4
const int buttonPin4 = 8;     // the number of the switch’s pin 8

//const int switchPin1 = 2;     // the number of the switch’s pin 1
//const int switchPin2 = 3;     // the number of the switch’s pin 2
//const int switchPin3 = 4;     // the number of the switch’s pin 4
//const int switchPin4 = 5;     // the number of the switch’s pin 8

// set variables:
int switchState1 = 0;         // variable for reading the switch’s status
int switchState2 = 0;         // variable for reading the switch’s status
int switchState3 = 0;         // variable for reading the switch’s status
int switchState4 = 0;         // variable for reading the switch’s status
byte test = B0000;            // Variable for printing value over serial debug

// keeps track of how "up or down" the ball has scrolled
volatile byte verticalPos;

// called when the trackball is scrolling up
void isrUp( void ) {
  // keep vertialPos from overflowing
  int temp = verticalPos + VERT_INC;
  if(temp > 255) temp = 255;
  verticalPos = temp;
  
  #if(LED_DEBUG_SERIAL)
    //Serial.print("isrUp  :");
    Serial.println(6, DEC);
    //delay(50);
  #endif
}

// called when the trackball is scrolling down
void isrDown( void ) {
  // keep verticalPos from underflowing
  int temp = verticalPos - VERT_INC;
  if(temp < 0) temp = 0;
  verticalPos = temp;
  
  #if(LED_DEBUG_SERIAL)
    //Serial.print("isrDown:");
    Serial.println(7, DEC);
    //delay(50);
  #endif
}

void setup()  { 
  #if(LED_DEBUG_SERIAL)
    Serial.begin(57600);    // opens serial port
  #endif
  
   //attachInterrupt(interrupt, function, mode)
  attachInterrupt(0, isrUp, CHANGE);
  attachInterrupt(1, isrDown, CHANGE);
  pinMode(BALL_BUTTON, INPUT);
  // Start serial debugging…

// initialize the switch pins as an input:
pinMode(switchPin1, INPUT);
pinMode(switchPin2, INPUT);
pinMode(switchPin3, INPUT);
pinMode(switchPin4, INPUT);
digitalWrite(switchPin1, HIGH);
digitalWrite(switchPin2, HIGH);
digitalWrite(switchPin3, HIGH);
digitalWrite(switchPin4, HIGH);
pinMode(buttonPin1, INPUT);
pinMode(buttonPin2, INPUT);
pinMode(buttonPin3, INPUT);
pinMode(buttonPin4, INPUT);
digitalWrite(buttonPin1, HIGH);
digitalWrite(buttonPin2, HIGH);
digitalWrite(buttonPin3, HIGH);
digitalWrite(buttonPin4, HIGH);
} 

void loop()  { 
  // write out to a LED
  if(digitalRead(BALL_BUTTON) == LOW){
 //analogWrite(LED_WHITE, 255);
 //analogWrite(LED_RED, 0);
  Serial.println("5");
  delay(100);
  // write out the opposite to the other LED
  //analogWrite(LED_BLUE, 0);
}else{
  //analogWrite(LED_WHITE, 0);
  //analogWrite(LED_RED, verticalPos);
  
  // write out the opposite to the other LED
  //analogWrite(LED_BLUE, ~verticalPos);
}
   
  // read the state of the switch’s individual pins:
switchState1 = digitalRead(switchPin1);
switchState2 = digitalRead(switchPin2);
switchState3 = digitalRead(switchPin3);
switchState4 = digitalRead(switchPin4);
if(digitalRead(buttonPin1)==LOW){
  //blinkLED(13,1,100);
  //LEFT BUTTON
  Serial.println("4");
  delay(100);
}
if(digitalRead(buttonPin2)==LOW){
  //blinkLED(13,2,100);
  // RIGHT BUTTON
  Serial.println("3");
  delay(100);
}
if(digitalRead(buttonPin3)==LOW){
  //blinkLED(13,3,100);
  // UP BUTTON
  Serial.println("1");
  delay(100);
}
if(digitalRead(buttonPin4)==LOW){
  //blinkLED(13,4,100);
  //DOWN BUTTON
  Serial.println("2");
  delay(100);
}
// check if the pushbutton is pressed.
// if it is, the buttonState is HIGH:
if (switchState1 == LOW) {
//Serial.println("Pin1 = High" );
bitSet(test, 0); //sets bit 0 (rightmost bit -000(1)) to 1
}
else {
//Serial.println("Pin1 = LOW" );
bitClear(test, 0); //sets bit 0 (rightmost bit -000(0)) to 0
}
if (switchState2 == LOW) {
//Serial.println("Pin2 = High" );
bitSet(test, 1); //sets bit 1 (second rightmost bit -00(1)0) to 1
}
else {
//Serial.println("Pin2 = LOW" );
bitClear(test, 1); //sets bit 1 (second rightmost bit -00(0)0) to 0
}
if (switchState3 == LOW) {
//Serial.println("Pin3 = High" );
bitSet(test, 2); //sets bit 2 (second leftmost bit -0(1)00) to 1
}
else {
//Serial.println("Pin3 = LOW");
bitClear(test, 2); //sets bit 2 (second leftmost bit -0(0)00) to 0
}
if (switchState4 == LOW) {
//Serial.println("Pin4 = High" );
bitSet(test, 3); //sets bit 3 (leftmost bit -(1)000) to 1
}
else {
//Serial.println("Pin4 = LOW");
bitClear(test, 3); //sets bit 3 (leftmost bit -(0)000) to 1
}
//Serial.println("\n");


//Remove comment on these lines to see binary output:
//Serial.print(switchState1);
//Serial.print(switchState2);
//Serial.print(switchState3);
//Serial.println(switchState4);

//Serial.println(char(test) +0);//converts to char, and prints ASCII value of 0-15
//Serial.println(char(test) +1);//uncomment for 1-16…
int colorState = char(test) +1;
if(colorState>=6 && colorState <=8){
  analogWrite(LED_RED, 255);
  analogWrite(LED_WHITE, 0);
  analogWrite(LED_BLUE, 0);
  analogWrite(LED_GREEN, 0);
}
else if(colorState>=10 && colorState <=12){
  analogWrite(LED_RED, 0);
  analogWrite(LED_WHITE, 0);
  analogWrite(LED_BLUE, 0);
  analogWrite(LED_GREEN, 255);
}
else if(colorState>=14 && colorState <=16){
  analogWrite(LED_RED, 0);
  analogWrite(LED_WHITE, 0);
  analogWrite(LED_BLUE, 255);
  analogWrite(LED_GREEN, 0);
}else if(colorState==13){
  analogWrite(LED_RED, 0);
  analogWrite(LED_WHITE, 0);
  analogWrite(LED_BLUE, 127);
  analogWrite(LED_GREEN, 127);
}
else if(colorState==9){
  analogWrite(LED_RED, 127);
  analogWrite(LED_WHITE, 0);
  analogWrite(LED_BLUE, 0);
  analogWrite(LED_GREEN, 127);
}
else if(colorState==5){
  analogWrite(LED_RED, 127);
  analogWrite(LED_WHITE, 127);
  analogWrite(LED_BLUE, 0);
  analogWrite(LED_GREEN, 0);
}
else if(colorState==1){
  analogWrite(LED_RED, 0);
  analogWrite(LED_WHITE, 127);
  analogWrite(LED_BLUE, 127);
  analogWrite(LED_GREEN, 0);
}
else{
  analogWrite(LED_WHITE, 255);
  analogWrite(LED_RED, 0);
  analogWrite(LED_BLUE, 0);
  analogWrite(LED_GREEN, 0);
}
//(colorState>=2 || colorState <=4)
//Serial.println("\n");
delay(100);
}
////////////////// UTILITIES //////////////////
// this function blinks the an LED light as many times as requested, at the requested blinking rate
void blinkLED(byte targetPin, int numBlinks, int blinkRate) {
  for (int i=0; i<numBlinks; i++) {
    digitalWrite(targetPin, HIGH);   // sets the LED on
    delay(blinkRate);                     // waits for blinkRate milliseconds
    digitalWrite(targetPin, LOW);    // sets the LED off
    delay(blinkRate);
  }
}

