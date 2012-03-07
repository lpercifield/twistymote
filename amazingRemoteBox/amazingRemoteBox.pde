#include <NewSoftSerial.h>
#include <IRremote.h>
#include <IRremoteInt.h>


/*
 * IRremote: IRsendDemo - demonstrates sending IR codes with IRsend
 * An IR LED must be connected to Arduino PWM pin 3.
 * Version 0.1 July, 2009
 * Copyright 2009 Ken Shirriff
 * http://arcfn.com
 */
 

/*
BUTTON CONFIGURATION
UP = 1;
DOWN =2;
RIGHT = 3;
LEFT = 4;
BALL = 5;
SCROLL UP = 6;
SCROLL DOWN = 7;


*/
IRsend irsend; //this is the instance of the IRremote library
 
// just added my own array for the raw signal
unsigned int powerOn[68] = {4450,4500,550,1700,500,1750,500,1750,500,600,550,600,500,600,550,600,500,600,550,1700,550,1700,550,1700,500,600,550,600,500,600,550,600,500,650,500,600,550,1700,500,650,500,600,550,600,500,600,550,600,500,600,550,1700,550,600,500,1700,550,1700,550,1700,550,1700,500,1750,500,1750,500};
unsigned int soundUp[68] = {4450,4500,550,1700,550,1700,500,1750,500,600,550,600,500,600,550,600,500,600,550,1700,550,1700,550,1700,500,650,500,600,550,600,500,600,550,600,500,1750,500,1700,550,1700,550,600,500,600,550,600,500,600,550,600,500,600,550,600,550,600,500,1700,550,1700,550,1700,550,1700,500,1750,500};
unsigned int soundDown[68] = {4400,4550,500,1750,500,1700,550,1700,550,600,500,600,550,600,500,600,550,600,500,1750,500,1750,500,1700,550,600,500,650,500,600,550,600,500,600,550,1700,550,1700,500,600,550,1700,550,600,500,600,550,600,500,600,550,600,500,600,550,1700,550,600,500,1750,500,1750,500,1700,550,1700,550};
unsigned int channelUp[68] = {4400,4550,500,1700,550,1700,550,1700,550,600,500,600,550,600,500,600,550,600,500,1750,500,1700,550,1700,550,600,500,600,550,600,500,650,500,600,550,600,500,1700,550,600,550,600,500,1700,550,600,500,650,500,600,550,1700,500,600,550,1700,550,1700,550,600,500,1700,550,1700,550,1700,550};
unsigned int channelDown[68] = {4450,4500,500,1750,500,1750,500,1700,550,600,500,650,500,600,550,600,500,600,550,1700,500,1750,500,1750,500,600,550,600,500,600,550,600,500,600,550,600,500,650,500,600,550,600,500,1700,550,600,500,650,500,600,500,1750,500,1750,500,1750,500,1700,550,600,500,1750,500,1750,500,1700,550};

NewSoftSerial mySerial(12, 13); // create a serail port for the xbee radio
byte remoteID = 0x05; //Stuff for the remote controller
int irledPin=3; //define a pin for IR LED

//THESE ARE THE NUMBERS THAT THE REMOTE SENDS
const char up = '1'; //up button
const char down ='2'; //down button
const char right = '3'; //right button
const char left = '4'; //left button
const char ball = '5'; //when the track ball is pressed
const char scrollup = '6'; // when you scroll up
const char scrolldown = '7'; //when you scroll down

     
//int colorledPin=7;     //define a pin for Color LED

void setup()
{
    mySerial.begin(57600); //sent the baud rate for the xbee
    Serial.begin(57600);  //Begin serial communcation
    pinMode( irledPin, OUTPUT ); //set the ir led pin to output
    //pinMode( colorledPin, OUTPUT ); // this is currently not used
    pinMode(11,OUTPUT); // set up the power and ground for the xbee
    pinMode(10,OUTPUT); // set up the power and ground for the xbee
    digitalWrite(11,HIGH); //this powers the xbee
    digitalWrite(10,LOW); //this grounds the xbee

}

void loop()
{
  
  //delay(10); //short delay for faster response to light.
  if (mySerial.available()) { //we need to read the serial input
      char message = (char)mySerial.read(); // make this a char
      if(message == up){ //check the message
        irsend.sendRaw(soundUp,68,38); //send the command
        delay(100);
        Serial.println("up"); //this prints out a debug message to the usb serial
      }
      if(message == down){
        irsend.sendRaw(soundDown,68,38);
        delay(100);
        Serial.println("down");
      }
      if(message == left || message == scrolldown){
        irsend.sendRaw(channelDown,68,38);
        delay(100);
        Serial.println("left");
      }
      if(message == right || message == scrollup){
        irsend.sendRaw(channelUp,68,38);
        delay(100);
        Serial.println("right");
      }
      if(message == ball){
        irsend.sendRaw(powerOn,68,38);
        delay(100);
        Serial.println("ball");
      }
      if(message == scrolldown){
        irsend.sendRaw(channelDown,68,38);
        //delay(100);
        Serial.println("scrolldown");
      }
      if(message == scrollup){
        irsend.sendRaw(channelUp,68,38);
        //delay(100);
        Serial.println("scrollup");
      }
  }
}

