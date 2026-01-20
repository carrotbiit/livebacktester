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
    //draw stats
    fill(255);
    noStroke();
    text("Ticker Symbol: " + tester.tickerSymbol, this.topLeft.x + 50, this.topLeft.y + 20);
    
    //draw x and y axis
    stroke(255);
    line(this.topLeft.x, this.topLeft.y + (this.bottomRight.y - this.topLeft.y) * 0.1, this.topLeft.x, this.bottomRight.y);
    line(this.topLeft.x, this.bottomRight.y, this.bottomRight.x, this.bottomRight.y);
    
    if (this.tester.curIndex - this.tester.startIndex > 1){
      
      //get candle data fit to graph
      int start = max(0, this.tester.curIndex - maxCandles - this.tester.startIndex);
      
      if (start == 0){
        start = this.tester.startIndex;
      }
      else{
        start = this.tester.curIndex - maxCandles;
      }
      
      int len = min(maxCandles, this.tester.curIndex - this.tester.startIndex);
      
      Candle[] graphData = new Candle[len];
      int[] tradeHistory = new int[len];
      
      for (int i = 0; i < len; i++) {
        graphData[i] = new Candle(this.tester.data[start + i]);
        tradeHistory[i] = this.tester.history.get(this.tester.history.size() - len + i);
      }
      
      //draw candles
      float candleWidth;
      if (graphData.length > 50){
        candleWidth = (this.bottomRight.x - this.topLeft.x) / graphData.length;
      }
      else{
        candleWidth = (this.bottomRight.x - this.topLeft.x) / 50;
      }
      
      float high = getMaxHigh(graphData);
      float low = getMinLow(graphData);
      
      fill(255);
      //draw and label x-axis dates
      line(this.topLeft.x, this.bottomRight.y, this.topLeft.x, this.bottomRight.y + 5);
      text(graphData[0].date, this.topLeft.x - 30, this.bottomRight.y + 20);
      
      line(this.topLeft.x + candleWidth * len, this.bottomRight.y, this.topLeft.x + candleWidth * len, this.bottomRight.y + 5);
      text(graphData[len-1].date, this.topLeft.x + candleWidth * len - 30, this.bottomRight.y + 20);
      text("Date (YYYY-MM-DD)", (this.topLeft.x + this.bottomRight.x) / 2 - 40, this.bottomRight.y + 20);
      
      //draw and label y-axis tickmarks
      float spacing = (this.bottomRight.y - this.topLeft.y) / 10;
      float priceSpacing = (high - low) / 10;
      
      stroke(255);
      fill(255);
      for (int i = 0; i < 10; i++){
        line(this.topLeft.x - 5, this.bottomRight.y - i * spacing, this.topLeft.x, this.bottomRight.y - i * spacing);
        text(roundAny(low + priceSpacing * i, 3), this.topLeft.x - 45, this.bottomRight.y - i * spacing + 4);
      }
      text("Price ($)", this.topLeft.x - 45, this.topLeft.y + 20);
      
      if (high == low){
        high += 1;
      }
      
      for (int i = 0; i < graphData.length; i++){
        
        float y1 = map(graphData[i].close, low * 0.8, high * 1.2, this.bottomRight.y, this.topLeft.y);
        float y2 = map(graphData[i].open, low * 0.8, high * 1.2, this.bottomRight.y, this.topLeft.y);
        
        float y = min(y1, y2);
        float candleHeight = abs(y2-y1);
        
        float yHigh = map(graphData[i].high, low * 0.8, high * 1.2, this.bottomRight.y, this.topLeft.y);;
        float yLow = map(graphData[i].low, low * 0.8, high * 1.2, this.bottomRight.y, this.topLeft.y);
        
        if (graphData[i].close >= graphData[i].open){
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
        
        //draw buy and sell signals
        if (tradeHistory[i] == 1){
          fill(0, 255, 165);
          triangle(this.topLeft.x + candleWidth * (i-1), yLow + 30, this.topLeft.x + candleWidth * (i+2), yLow + 30, this.topLeft.x + candleWidth * (i+0.5), yLow + 20); 
        }
        else if (tradeHistory[i] == -1){
          fill(255, 165, 0);
          triangle(this.topLeft.x + candleWidth * (i-1), yHigh - 30, this.topLeft.x + candleWidth * (i+2), yHigh - 30, this.topLeft.x + candleWidth * (i+0.5), yHigh - 20); 
        }
        
        
        //current price line
        if (i == len-1){
          stroke(255);
          line(this.topLeft.x, y1, this.bottomRight.x, y1);
        }
      }
    }
    
    
  }
  
  
}
