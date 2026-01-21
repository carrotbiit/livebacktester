import g4p_controls.*;

boolean paused = false;

TradingGraph graph;

void setup(){
  
  size(800, 500);
  frameRate(30);
  createGUI();
  strategyWindow.setVisible(false);
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  
  ArrayList<Indicator> indicators = new ArrayList<Indicator>();
  
  MACD macd = new MACD(50, 200);
  RSI rsi = new RSI(14, 70, 30);
  
  indicators.add(macd);
  indicators.add(rsi);
  
  Tester tester = new Tester(indicators, "AAPL", "2019-01-01", "2026-01-01");
  
  graph = new TradingGraph(tester, new PVector(50, 100), new PVector(750, 450));
}

void draw(){
  background(0);
  
  graph.drawMe();
  graph.update();
  
}
