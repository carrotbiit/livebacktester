class Tester{
  ArrayList<Indicator> indicators;
  Candle[] data;
  String interval;
  int startIndex;
  int endIndex;
  int curIndex;
  
  Tester(ArrayList<Indicator> i, Candle[] d, String s, String e, String intvl){
    this.indicators = i;
    this.data = d;
    this.interval = intvl;
    
    this.startIndex = getIndexByDate(d, s);
    this.endIndex = getIndexByDate(d, e);
    this.curIndex = startIndex;
  }
  
  void step(){
    if (curIndex < endIndex){
      this.curIndex += 1;
      Candle[] curData = new Candle[this.curIndex-this.startIndex];
      for(int i = this.startIndex; i < this.curIndex + 1; i++){
        curData[i-this.startIndex] = this.data[i];
      }
      
      boolean buy = true;
      for (int i = 0; i < this.indicators.size(); i++){
        int prediction = this.indicators.get(i).signal(curData);
        
        if (this.indicators.get(i).lastSignal == 1){}
      }
    }
  }
}
