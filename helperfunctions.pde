float getMaxHigh(Candle[] data){
  float max = data[0].high;
  for (Candle candle: data){
    if (candle.high > max){
      max = candle.high;
    }
  }
  return max;
}

float roundAny(float n, int digits){
  float newn = round(n * pow(10, digits)) / pow(10, digits);
  return newn;
  
}

float getAveragePrice(Candle[] data, String column, int start, int end){
  int loopstart;
  int loopend;
  if (start < 0){
    loopstart = data.length + start;
  }
  else{
    loopstart = start;
  }
  if (end < 0){
    loopend = data.length + end;
  }
  else{
    loopend = end;
  }
  
  float total = 0;
  int count = 0;
  for (int i = loopstart; i < loopend+1; i++){
    if (column.equals("open")){
      total += data[i].open;
    }
    if (column.equals("close")){
      total += data[i].close;
    }
    count ++;
  }
  
  return total/count;
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

int getIndexByDate(Candle[] data, String date){
  int index = 0;
  for (Candle candle: data){
    if (candle.date.equals(date)){
      return index;
    }
    index += 1;
  }
  return -1;
}
