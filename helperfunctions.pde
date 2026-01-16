float getAveragePrice(Candle[] data, String column, int start, int end){
    int loopstart;
    int loopend;
    if (start < 0){
      loopstart = data.length - start;
    }
    else{
      loopstart = start;
    }
    if (end < 0){
      loopend = data.length - end;
    }
    else{
      loopend = end;
    }
    
    float total = 0;
    for (int i = loopstart; i < loopend+1; i++){
      if (column == "open"){
        total += data[i].open;
      }
      if (column == "close"){
        total += data[i].close;
      }
      
    }
    
    return total/(end-start+1);
}

Candle[] getStockData(String symbol){
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
