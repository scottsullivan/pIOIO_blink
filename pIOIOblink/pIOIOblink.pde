// - - - - - - - - - - - - - - - - - - - - - - -
// PIOIO BLINK
// MIT License (MIT)
// Copyright (c) 2014 Scott Sullivan
// - - - - - - - - - - - - - - - - - - - - - - -

// - - - - - - - - - - - - - - - - - - - - - - - 
// LIBRARIES
// - - - - - - - - - - - - - - - - - - - - - - - 
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// ANDROID IMPORT
// - - - - - - - - - - - - - - - - - - - - - - - 
import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// GLOBAL VARIABLES
// - - - - - - - - - - - - - - - - - - - - - - - 
DigitalOutput led1;  //naming the led and declaring it to be a digital output
boolean light1On = false; //boolean to control the LED
int bcolor = 0; //variable for the background color of the application

// - - - - - - - - - - - - - - - - - - - - - - - 
// SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void setup() {
  new PIOIOManager(this).start(); //begin PIOIO
  
  size(displayWidth, displayHeight, P3D); //size of sketch
  orientation(PORTRAIT); //orientation of sketch
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// DRAW LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void draw() {
  background(bcolor); //background color of sketch
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// MOUSE EVENT
// - - - - - - - - - - - - - - - - - - - - - - - 
void mousePressed() {
  if (light1On == true) {
    light1On = false;
    bcolor = 0;
  }
  else if (light1On == false) {
    light1On = true;
    bcolor = 255;
  }
}
