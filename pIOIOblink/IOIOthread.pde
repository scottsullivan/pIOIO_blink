// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void ioioSetup(IOIO ioio) throws ConnectionLostException {
  led1 = ioio.openDigitalOutput(1);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void ioioLoop(IOIO ioio) throws ConnectionLostException {
  try {
    led1.write(light1On);
  }
  catch (ConnectionLostException e) {
  }
}
