class TradingGraph{
  
  Tester tester;
  PVector topLeft;
  PVector bottomRight;
  
  int minCandles = 50;
  int maxCandles = 200;
  
  TradingGraph(Tester t, PVector tL, PVector bR){
    this.tester = t;
    this.topLeft = tL;
    this.bottomRight = bR;
    
  }
  
  void update(){
    this.tester.step();
  }
  
  void drawMe(){
    
    //draw x and y axis
    
    stroke(255);
    line(this.topLeft.x, this.topLeft.y, this.topLeft.x, this.bottomRight.y);
    line(this.topLeft.x, this.bottomRight.y, this.bottomRight.x, this.bottomRight.y);
    
    if (this.tester.curIndex - this.tester.startIndex > 1){
      //get candle data fit to graph
      int start = max(0, this.tester.curIndex - maxCandles);
      int len = min(maxCandles, this.tester.curIndex);
      
      Candle[] graphData = new Candle[len];
      int[] tradeHistory = new int[len];
      
      for (int i = 0; i < len; i++) {
        graphData[i] = new Candle(this.tester.data[start + i]);
        tradeHistory[i] = this.tester.history.get(start + i);
      }
      
      //println(getMaxHigh(graphData));
      
      //draw and label y-axis tickmarks
      float spacing = (this.topLeft.y - this.bottomRight.y) / 10;
      float priceSpacing = getMaxHigh(graphData) / 10;
      
      stroke(255);
      fill(255);
      for (int i = 0; i < 10; i++){
        line(this.topLeft.x - 5, this.bottomRight.y + i * spacing, this.topLeft.x, this.bottomRight.y + i * spacing);
        text(roundAny(priceSpacing * i, 3), this.topLeft.x - 40, this.bottomRight.y + i * spacing + 4);
      }
      
      
      //draw candles
      float candleWidth;
      if (graphData.length > 50){
        candleWidth = (this.bottomRight.x - this.topLeft.x) / graphData.length;
      }
      else{
        candleWidth = (this.bottomRight.x - this.topLeft.x) / 50;
      }
      
      for (int i = 0; i < graphData.length; i++){
        
        float high = getMaxHigh(graphData);
        float low = getMinLow(graphData);
        
        float y1 = map(graphData[i].close, low, high, this.bottomRight.y, this.topLeft.y);
        float y2 = map(graphData[i].open, low, high, this.bottomRight.y, this.topLeft.y);
        
        float y = min(y1, y2);
        float candleHeight = abs(y2-y1);
        
        float yHigh = map(graphData[i].high, low, high, this.bottomRight.y, this.topLeft.y);;
        float yLow = map(graphData[i].low, low, high, this.bottomRight.y, this.topLeft.y);
        
        if (graphData[i].close > graphData[i].open){
          fill(0, 255, 0);
          stroke(0, 255, 0);
        }
        else {
          fill(255, 0, 0);
          stroke(255, 0, 0);
        }
        
        
        line(this.topLeft.x + candleWidth * (i + 0.5), yHigh, this.topLeft.x + candleWidth * (i + 0.5), y);
        line(this.topLeft.x + candleWidth * (i + 0.5), y + candleHeight, this.topLeft.x + candleWidth * (i + 0.5), yLow);
        
        noStroke();
        rect(this.topLeft.x + candleWidth * i, y, candleWidth, candleHeight);
        
      }
    }
    
    
  }
  
  
}
