class TradingGraph{
  
  Tester tester;
  PVector topLeft;
  PVector bottomRight;
  
  int minCandles = 50;
  int maxCandles = 200;
  
  //initialize tester and size constraints
  TradingGraph(Tester t, PVector tL, PVector bR){
    this.tester = t;
    this.topLeft = tL;
    this.bottomRight = bR;
    
  }
  
  //alternate for initializing only size and setting tester later
  TradingGraph(PVector tL, PVector bR){
    this.topLeft = tL;
    this.bottomRight = bR;
    
  }
  
  //step tester 1 frame in future
  void update(){
    this.tester.step();
  }
  
  //draw graph
  void drawMe(){
    //draw stats, stock symbol, portfolio value, percent return
    fill(255);
    noStroke();
    text("Ticker Symbol: " + tester.tickerSymbol, this.topLeft.x + 25, this.topLeft.y + 20);
    text("Portfolio Value: $" + roundAny(this.tester.cash + this.tester.sharesOwned * this.tester.data[this.tester.curIndex].close, 2), this.topLeft.x + 150, this.topLeft.y + 20);
    if (this.tester.cash + this.tester.sharesOwned * this.tester.data[this.tester.curIndex].close < 100000){
      fill(255, 0, 0);
    }
    else {
      fill(0, 255, 0);
    }
    text("Percent Return: " + roundAny(((this.tester.cash + this.tester.sharesOwned * this.tester.data[this.tester.curIndex].close) - 100000) / 100000 * 100, 2) + "%", this.topLeft.x + 310, this.topLeft.y + 20); 
    
    
    //draw x and y axis
    stroke(255);
    line(this.topLeft.x, this.topLeft.y + (this.bottomRight.y - this.topLeft.y) * 0.1, this.topLeft.x, this.bottomRight.y);
    line(this.topLeft.x, this.bottomRight.y, this.bottomRight.x, this.bottomRight.y);
    
    //if there is enough data, draw candles on graph
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
      
      //get highest and lowest price out of all data
      float high = getMaxHigh(graphData);
      float low = getMinLow(graphData);
      
      //get max volume from all data
      float maxVolume = getMaxVolume(graphData);
      
      //label volume
      fill(255);
      text("Volume (relative)", this.bottomRight.x - 50, this.bottomRight.y - 50);
      
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
      
      //change high if high and low are the same, prevents errors when mapping
      if (high == low){
        high += 1;
      }
      
      //draw candlesticks
      for (int i = 0; i < graphData.length; i++){
        
        //map body of candle (close and open price) to y of graph
        float y1 = map(graphData[i].close, low - 1, high + 1, this.bottomRight.y - 50, this.topLeft.y + 50);
        float y2 = map(graphData[i].open, low - 1, high + 1, this.bottomRight.y - 50, this.topLeft.y + 50);
        
        float y = min(y1, y2);
        float candleHeight = abs(y2-y1);
        
        //map candle wicks (high and low price) to y of graph
        float yHigh = map(graphData[i].high, low - 1, high + 1, this.bottomRight.y - 50, this.topLeft.y + 50);
        float yLow = map(graphData[i].low, low - 1, high + 1, this.bottomRight.y - 50, this.topLeft.y + 50);
        
        //map volume level to graph
        float volumeHeight = map(graphData[i].volume, 0, maxVolume + 1, 0, 100);
        
        //draw volume bar at bottom of graph
        noStroke();
        fill(0, 0, 255);
        rect(this.topLeft.x + candleWidth * (i + 0.3), this.bottomRight.y, candleWidth * 0.4, -volumeHeight);
        
        //check if candle is red or green
        if (graphData[i].close >= graphData[i].open){ //green candle: close > open
          fill(0, 255, 0);
          stroke(0, 255, 0);
        }
        else { //red candle: close < open
          fill(255, 0, 0);
          stroke(255, 0, 0);
        }
        
        //draw candle wicks
        line(this.topLeft.x + candleWidth * (i + 0.5), yHigh, this.topLeft.x + candleWidth * (i + 0.5), y);
        line(this.topLeft.x + candleWidth * (i + 0.5), y + candleHeight, this.topLeft.x + candleWidth * (i + 0.5), yLow);
        
        //draw candle body
        noStroke();
        rect(this.topLeft.x + candleWidth * i, y, candleWidth, candleHeight);
        
        //draw buy and sell signals as triangles
        if (tradeHistory[i] == 1){
          fill(0, 255, 165);
          triangle(this.topLeft.x + candleWidth * (i-1), yLow + 30, this.topLeft.x + candleWidth * (i+2), yLow + 30, this.topLeft.x + candleWidth * (i+0.5), yLow + 20); 
        }
        else if (tradeHistory[i] == -1){
          fill(255, 165, 0);
          triangle(this.topLeft.x + candleWidth * (i-1), yHigh - 30, this.topLeft.x + candleWidth * (i+2), yHigh - 30, this.topLeft.x + candleWidth * (i+0.5), yHigh - 20); 
        }
        
        
        //current price line, if there is an open trade make it green
        if (i == len-1){
          if (openLong){
            stroke(0, 255, 165);
          }
          else{
            stroke(255);
          }
          line(this.topLeft.x, y1, this.bottomRight.x, y1);
        }
      }
    }
    
    
  }
  
  
}
