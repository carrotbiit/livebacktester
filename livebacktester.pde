import g4p_controls.*;
import java.io.File;

//global variables
boolean paused = false;
boolean runningSim = false;

boolean openLong = false;

//initalize class objects
TradingGraph graph = new TradingGraph(new PVector(50, 100), new PVector(750, 450));
ArrayList<Indicator> indicators = new ArrayList<Indicator>();

void setup() {
  
  //set up gui and make all but main window invisible
  size(800, 500);
  frameRate(30);
  createGUI();
  strategyWindow.setVisible(false);
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  MACDWindow.setVisible(false);
  RSIWindow.setVisible(false);
  stochoscWindow.setVisible(false);
  warningWindow.setVisible(false);
  helpWindow.setVisible(false);
}

void draw() {
  background(0);
  
  //if stock simulation is running, update the graph
  if (runningSim) {
    graph.drawMe();
    graph.update();
  }
}
