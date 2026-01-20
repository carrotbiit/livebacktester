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
    
    if (this.tester.curIndex - this.tester.startIndex != 0){
      //get candle data fit to graph
      int start = max(0, this.tester.curIndex - maxCandles);
      int len = min(maxCandles, this.tester.curIndex);
      
      Candle[] graphData = new Candle[len];
      int[] tradeHistory = new int[len];
      
      for (int i = 0; i < len; i++) {
        graphData[i] = this.tester.data[start + i];
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
        candleWidth = (this.bottomRight.y - this.topLeft.x) / graphData.length;
      }
      else{
        candleWidth = (this.bottomRight.y - this.topLeft.x) / 50;
      }
      
      for (int i = 0; i < graphData.length; i++){
        
        float y1 = (graphData[i].close / getMaxHigh(graphData)) * (this.topLeft.y - this.bottomRight.y) + this.bottomRight.y;
        float y2 = (graphData[i].open / getMaxHigh(graphData)) * (this.topLeft.y - this.bottomRight.y) + this.bottomRight.y;
        
        float yHigh = (graphData[i].high / getMaxHigh(graphData)) * (this.topLeft.y - this.bottomRight.y) + this.bottomRight.y;
        float yLow = (graphData[i].low / getMaxHigh(graphData)) * (this.topLeft.y - this.bottomRight.y) + this.bottomRight.y;
        
        if (graphData[i].close > graphData[i].open){
          fill(0, 255, 0);
          noStroke();
          
          rect(candleWidth * i, y1, candleWidth * (i+1), y2);
          println(candleWidth * i + ", " + candleWidth * (i+1) + ", " + (candleWidth * (i+1) - candleWidth * i));
          
          stroke(0, 255, 0);
          //line(candleWidth * (i+0.5), y1, candleWidth * (i+0.5), yHigh);
          //line(candleWidth * (i+0.5), y2, candleWidth * (i+0.5), yLow);
        }
        else {
          fill(255, 0, 0);
          noStroke();
          
          rect(candleWidth * i, y1, candleWidth * (i+1), y2);
          
          stroke(255, 0, 0);
          //line(candleWidth * (i+0.5), y1, candleWidth * (i+0.5), yLow);
          //line(candleWidth * (i+0.5), y2, candleWidth * (i+0.5), yHigh);
        }
        
        
      }
    }
    
    
  }
  
  
}
