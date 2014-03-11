pIOIO_blink
===========

<img src="http://imgur.com/l81OXXe.jpg" />

For this project we're going to use <a href="http://processing.org/">Processing</a>, a language built on Java to build an Android application that will simply turn on and off a LED every time you touch the screen using the Android IOIO board. The IOIO is a microcontroller and has very similar capabilities to an Arduino, except this microcontroller specifically plays nicely with Android devices. In this post, we'll be using the IOIO board for simple digital output, the most basic IOIO capability. We can also use the IOIO for pulse-width-modulated digital output and analog input.

If you're not familiar with using Processing to write Android applications check out this <a href="http://processing.org/tutorials/android/">Android Processing Tutorial</a> by Jer Thorp and the <a href="http://wiki.processing.org/w/Android">Android Processing Wiki.</a> We'll specificially be using the <a href="https://github.com/PinkHatSpike/pioio">PIOIO</a> library for Processing by PinkHatSpike.

Here's what it will look like (<a href="https://vimeo.com/88686061">link to Vimeo page</a>):
<a href="https://vimeo.com/88686061"><img src="http://i.imgur.com/BMr66Ti.jpg" title="Video link" /></a>

### Hardware used
Before we dig in to the code, you'll need to pick up this hardware. You can get most of it from <a href="https://www.sparkfun.com/">Sparkfun</a>.
  * <a href="https://www.sparkfun.com/products/11343">IOIO-OTG</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9434">Bluetooth USB Module Mini</a> from Sparkfun
  * <a href="http://www.adafruit.com/products/328">Lithium Ion Polymer Battery - 3.7v 2500mAh</a> from Adafruit
  * <a href="https://www.sparkfun.com/products/12043">Breadboard - Mini Modular (White)</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9140">Jumper Wires Premium 6" M/F</a> from Sparkfun
  * <a href="http://www.amazon.com/Samsung-Nexus-Android-Phone-Sprint/dp/B0050DDVUI">Nexus S 4G</a> by Samsung (any Android phone will do)
  * <a href="https://www.sparkfun.com/products/9594">LED - Basic Yellow 5mm</a> from Sparkfun

### LED wiring
The wiring for this project is extremely simple, only two connections are needed!
  * Connect the shorter lead (negative, cathode) of the LED to ground (GND) on the IOIO board
  * Connect the longer lead (positive, anode) of the LED to the #1 pin on the IOIO board

### Step 1: Importing Libraries / Android
First we have to add appropriate IOIO libraries and parts of the Android API. Before you can import the PIOIO library to your Processing sketch, you have to download the library from <a href="https://github.com/PinkHatSpike/pioio">here</a> and put it in your libraries folder. After the library is in the libraries folder we bring it in to our project, this happens before the setup loop.
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

2a. Name the LED variable and specify that it's a digital output.
```
DigitalOutput led1;
```
2b. Make a boolean to control the light.
```
boolean light1On = false; //boolean to control the LED
```
2c. Create an integer for our background color.
```
int bcolor = 0; //variable for the background color of the application
```

### Step 3: Processing setup
The setup chunk is ran once at the begining of the sketch and is in the `void setup()` funtion, here we start the PIOIO communication and declare the size of our sketch as well as choose the orientation of our sketch.

3a. Instantiate pIOIO
```
  new PIOIOManager(this).start();
```
3b. Set the size of the Android application, you can specify specific pixel dimensions or have it auto-detect the display width and display height of the device. P3D is the render mode, in case later you need something to be 3D.
```
  size(displayWidth, displayHeight, P3D);
```
3c. Set the orientation of the Android application, here it's portrait but you could also choose `orientation(LANDSCAPE)` or not include this if you don't want to lock the orientation.
```
  orientation(PORTRAIT); //orientation of sketch
```

### Step 4: Processing draw loop
The draw loop is run ~60 times per second default and is in the `void draw()` function. In the draw loop, we're only drawing the background color of our screen.
```
  background(bcolor); //background color of sketch
```

### Step 5: The mouse event
Inside the `void mousePressed()` function we have an if-else statement where if the screen is tapped, it checks if the light is on or off. If it's on, the light will turn off and the background color of the application will go black. If it's off, the light will turn on and the background color will turn white.
```
  if (light1On) {
    light1On = false;
    bcolor = 0;
  }
  else if (light1On == false) {
    light1On = true;
    bcolor = 255;
  }
```

### Step 6: IOIO thread setup
The IOIO functionality resides in a separate paralell thread that is structured similarly to the Processing `void setup()` and `void draw()` functions. The IOIO setup is in the `void ioioSetup(IOIO ioio)` function and is basically Java and only executes if it's connected to the IOIO. The function declaration is followed by `throws ConnectionLostException` before the opening curly bracket.

In the IOIO thread setup we link our `led1` variable to pin #1 on the board and declare that it is to be used for digital output.
```
  led1 = ioio.openDigitalOutput(1);
```

### Step 7: IOIO thread loop
The IOIO thread loop mirrors the functionality of the `void draw()` processing funtion, is also basically Java and also only executes if it's connected to the IOIO. The function declaration is also followed by `throws ConnectionLostException` before the opening curly bracket.

6a. The try block checks our `light1On` boolean. If it returns true, the light will turn on.
```
  try {
    led1.write(light1On);
  }
```
6b. The catch block is an exception handler and throws an error if the phone is not connected to the IOIO.
```
  catch (ConnectionLostException e) {
  }
```
### Run on device
Now you should be good to go. Before you run the application be sure to go to the Android menu in the Processing IDE and select "Sketch Permissions" and check off BLUETOOTH, BLUETOOTH_ADMIN, and INTERNET.

<img src="http://i.imgur.com/5WoRRN9.png" title="sketch permissions" />

And that's it! Run the sketch and you should now be able to touch anywhere on the screen and the screen color will toggle between being black and white and your LED should be turning on and off at the same time. 

