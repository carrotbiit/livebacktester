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
  
  void drawMe(){
    
    //get candle data fit to graph
    Candle[] data;
    int[] tradeHistory;
    
    if (this.tester.history.size() < maxCandles){
      data = new Candle[this.tester.history.size()];
      tradeHistory = new int[this.tester.history.size()];
      
      for(int i = this.tester.startIndex; i < this.tester.curIndex+1; i++){
        data[i-this.tester.startIndex] = this.tester.data[i];
        tradeHistory[i-this.tester.startIndex] = this.tester.history.get(i);
      }
    }
    
    else{
      data = new Candle[maxCandles];
      tradeHistory = new int[maxCandles];
      
      for(int i = this.tester.curIndex+1-maxCandles; i < this.tester.curIndex+1; i++){
        data[i-this.tester.curIndex+1-maxCandles] = this.tester.data[i];
        tradeHistory[i-this.tester.curIndex+1-maxCandles] = this.tester.history.get(i);
      }
    }
    
    
    
  }
}
