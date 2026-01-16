class StockData{
  String symbol;
  Candle[] data;
  
  StockData(String s){
    this.symbol = s;
    this.data = getStockData(this.symbol);
  }
  
  private Candle[] getStockData(String symbol){
    try{
      String[] alldata = loadStrings("stockdata/" + symbol + ".txt");
      
      Candle[] formatteddata = new Candle[alldata.length];
      
      for(int i = 0; i < alldata.length; i++){
        String[] tempdata = alldata[i].split(",");
        formatteddata[i] = new Candle(tempdata[0], float(tempdata[1]), float(tempdata[2]), float(tempdata[3]), float(tempdata[4]), int(tempdata[5]));
      }
      
      return formatteddata;
    }
    catch(NullPointerException e){
      return new Candle[0];
    }
  }
  
  
}
