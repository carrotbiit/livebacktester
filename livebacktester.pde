import g4p_controls.*;

MACD macd = new MACD(50, 200);
ArrayList<Indicator> list = new ArrayList<Indicator>();

void setup(){
  size(800, 500);
  background(0);
  createGUI();
  strategyWindow.setVisible(false);
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  
  Candle[] stockdata = getStockData("AAPL");
  
  list.add(macd);
  
  println(list.get(0).signal(stockdata));
}

void draw(){

}
