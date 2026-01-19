class Tester{
  ArrayList<Indicator> indicators;
  ArrayList<Integer> history;
  
  Candle[] data;
  String interval;
  int startIndex;
  int endIndex;
  int curIndex;
  float cash;
  float sharesOwned;
  
  Tester(ArrayList<Indicator> i, Candle[] d, String s, String e, String intvl){
    this.indicators = i;
    this.data = d;
    this.interval = intvl;
    
    this.startIndex = getIndexByDate(d, s);
    this.endIndex = getIndexByDate(d, e);
    this.curIndex = startIndex;
    
    this.cash = 100000;
    this.sharesOwned = 0;
  }
  
  Tester(ArrayList<Indicator> i, Candle[] d){
    this.indicators = i;
    this.data = d;
    this.interval = "daily";
    
    this.startIndex = 0;
    this.endIndex = this.data.length-1;
    this.curIndex = startIndex;
    
    this.cash = 100000;
    this.sharesOwned = 0;
  }
  
  void stepAll(){
    
    for (int i = 0; i < endIndex-startIndex + 1; i++){
      step();
    }
    println("portfolio value: " + int(this.cash + this.sharesOwned*this.data[this.data.length-1].close) + ", percent return : " + int(((this.cash + this.sharesOwned*this.data[this.data.length-1].close - 100000)/100000)*100));
    println("B&H percent return: " + int(((this.data[this.data.length-1].close-this.data[0].close)/this.data[0].close)*100));
  }
  
  void step(){
    if (curIndex < endIndex){
      
      this.curIndex += 1;
      
      //new list of candle data
      Candle[] curData = new Candle[this.curIndex-this.startIndex+1];
      for(int i = this.startIndex; i < this.curIndex+1; i++){
        curData[i-this.startIndex] = this.data[i];
      }
      
      
      //check if one indicator just signalled buy and all other indicators are already buy or also signalled buy
      if (sharesOwned == 0){
        int signal = 0;
        
        //for each indicator, get the signal
        for (int i = 0; i < this.indicators.size(); i++){
          int prediction = this.indicators.get(i).signal(curData);
          
          if (prediction == 2){ //if signal just flipped, buy
            signal += 1;
          }
          else if (prediction < 0){ //if signal has been on sell or just flipped to sell, do not buy
            signal -= 999;
          }
        }
        
        if (signal > 0){
          this.history.add(1);
          float price = curData[curIndex].close;
          
          this.sharesOwned = this.cash / price;
          this.cash = 0;
          println("bought " + this.sharesOwned + " shares at a price of " + int(price*this.sharesOwned));
        }
        else{
          this.history.add(0);
        }
      }
      
      else {
        int signal = 0;
        
        //for each indicator, get the signal
        for (int i = 0; i < this.indicators.size(); i++){
          int prediction = this.indicators.get(i).signal(curData);
          
          if (prediction == -2){ //if signal just flipped, buy
            signal += 1;
          }
        }
        
        if (signal > 0){
          this.history.add(-1);
          this.cash = this.sharesOwned * curData[curIndex].close;
          
          println("sold " + this.sharesOwned + " shares for total cost " + int(this.cash));
          
          this.sharesOwned = 0;
        }
        else{
          this.history.add(0);
        }
      }
      
      
    }
  }
}
