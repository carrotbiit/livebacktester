import g4p_controls.*;

boolean paused = false;

TradingGraph graph = new TradingGraph(new Tester(new ArrayList<Indicator>(), new Candle[0]), new PVector(50, 100), new PVector(750, 450));

void setup(){
  
  size(800, 500);
  frameRate(60);
  createGUI();
  strategyWindow.setVisible(false);
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  
  ArrayList<Indicator> indicators = new ArrayList<Indicator>();
  MACD macd = new MACD(50, 200);
  indicators.add(macd);
  Candle[] data = getStockData("AAPL");
  graph.tester = new Tester(indicators, data);
  
  //graph.tester.stepAll();
}

void draw(){
  background(0);
  
  graph.drawMe();
  graph.update();
  
}
