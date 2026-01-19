import g4p_controls.*;

MACD macd = new MACD(50, 200);
ArrayList<Indicator> indicators = new ArrayList<Indicator>();

void setup(){
  size(800, 500);
  background(0);
  createGUI();
  strategyWindow.setVisible(false);
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  
  Candle[] stockdata = getStockData("AAPL");
  
  indicators.add(macd);
  Tester tester = new Tester(indicators, stockdata);
  
  tester.stepAll();
}

void draw(){

}
