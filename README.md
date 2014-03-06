pIOIO_blink
===========

Introductory Android-Processing IOIO example.

### How to use Processing in Android Mode
   * <a href="http://processing.org/tutorials/android/">Android Processing Tutorial</a> by Jer Thorp
   * <a href="http://wiki.processing.org/w/Android">Android Processing Wiki</a>

### IOIO Processing library
  * <a href="https://github.com/PinkHatSpike/pioio">PIOIO</a> by PinkHatSpike

### Hardware used
  * <a href="https://www.sparkfun.com/products/11343">IOIO-OTG</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9434">Bluetooth USB Module Mini</a> from Sparkfun
  * <a href="http://www.adafruit.com/products/328">Lithium Ion Polymer Battery - 3.7v 2500mAh</a> from Adafruit
  * <a href="https://www.sparkfun.com/products/12043">Breadboard - Mini Modular (White)</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9140">Jumper Wires Premium 6" M/F</a> from Sparkfun
  * <a href="http://www.amazon.com/Samsung-Nexus-Android-Phone-Sprint/dp/B0050DDVUI">Nexus S 4G</a> by Samsung (any Android phone will do)
  * <a href="https://www.sparkfun.com/products/9594">LED - Basic Yellow 5mm</a> from Sparkfun

### LED wiring
  * Connect the shorter lead (negative, cathode) of the LED to ground (GND) on the IOIO board
  * Connect the longer lead (positive, anode) of the LED to the #1 pin on the IOIO board

## The Code

### Step 1: Importing Libraries / Android
First we have to add appropriate IOIO libraries and parts of the Android API, this happens before the setup loop.
```
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;
```

### Step 2: Adding global variables
Also before the setup loop, we name our LED and declare a boolean to control our light and an integer for our color.
```
DigitalOutput led1;  //naming the led and declaring it to be a digital output
boolean light1On = false; //boolean to control the LED
int bcolor = 0; //variable for the background color of the application
```

### Step 3: Processing setup
The setup chunk is ran once at the begining of the sketch, here we start the PIOIO communication and declare the size of our sketch as well as choose the orientation of our sketch (You can change it to LANDSCAPE if you'd like).
```
void setup() {
  new PIOIOManager(this).start(); //begin PIOIO
  
  size(displayWidth, displayHeight, P3D); //size of sketch
  orientation(PORTRAIT); //orientation of sketch
}
```

### Step 4: Processing draw loop
The draw loop is run ~60 times per second default, in the draw loop, we're only drawing the background color of our screen.
```
void draw() {
  background(bcolor); //background color of sketch
}
```

### Step 5: The mouse event
Explanation
```
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
```

### Step 6: IOIO thread setup
Explanation
```
void ioioSetup(IOIO ioio) throws ConnectionLostException {
  led1 = ioio.openDigitalOutput(1);
}
```

### Step 7: IOIO thread loop
Explanation
```
void ioioLoop(IOIO ioio) throws ConnectionLostException {
  try {
    led1.write(light1On);
  }
  catch (ConnectionLostException e) {
  }
}
```

