class Tester{
  ArrayList<Indicator> indicators;
  ArrayList<Integer> history = new ArrayList<Integer>();
  
  Candle[] data;
  int startIndex;
  int endIndex;
  int curIndex;
  float cash;
  float sharesOwned;
  String tickerSymbol;
  
  Tester(ArrayList<Indicator> i, String t, String s, String e){
    //initialize indicator list, ticker symbol, and stock data using function
    this.indicators = i;
    this.tickerSymbol = t;
    this.data = getStockData(this.tickerSymbol);
    
    //convert start and end index from string date to list index
    this.startIndex = getIndexByDate(this.data, s);
    this.endIndex = getIndexByDate(this.data, e);
    this.curIndex = startIndex;
    
    //initialize cash and shares owned
    this.cash = 100000;
    this.sharesOwned = 0;
  }
  
  //go one frame/day into the future
  void step(){
    
    //check if end of specified data has been reached
    if (curIndex < endIndex){
      
      this.curIndex += 1;
      
      //new list of candle data after going forward one frame
      Candle[] curData = new Candle[this.curIndex-this.startIndex+1];
      for(int i = this.startIndex; i < this.curIndex+1; i++){
        curData[i-this.startIndex] = this.data[i];
      }
      
      //if there is no open trade, get all the signals and check for a buy
      if (!openLong){
        int signal = 0;
        
        //for each indicator, get the signal
        for (int i = 0; i < this.indicators.size(); i++){
          int prediction = this.indicators.get(i).signal(curData);
          
          //add up all the signals
          signal += prediction;
        }
        
        //check if all signals are on buy and at least one has just flipped from sell to buy
        if (signal > this.indicators.size()){
          //log buy in trade history
          this.history.add(1);
          float price = this.data[curIndex].close;
          
          //buy shares and set cash to 0
          this.sharesOwned = this.cash / price;
          this.cash = 0;
          openLong = true;
        }
        else { //log do nothing in trade history if no buy
          this.history.add(0);
        }
      }
      
      //if currently in a long position, check for sell signal
      else {
        int signal = 0;
        
        //for each indicator, get the signal
        for (int i = 0; i < this.indicators.size(); i++){
          int prediction = this.indicators.get(i).signal(curData);
          
          if (prediction == -2){ //if signal just flipped, sell
            signal += 1;
          }
        }
        
        //only 1 signal has to be on sell to sell stock
        if (signal > 0){
          //log sell in history, compute cash and set owned shares to 0
          this.history.add(-1);
          this.cash = this.sharesOwned * this.data[curIndex].close;
          
          openLong = false;
          
          this.sharesOwned = 0;
        }
        else{//log do nothing in trade history if no sell
          this.history.add(0);
        }
      }
      
      
    }
  }
}
