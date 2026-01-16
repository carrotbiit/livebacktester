String[][] getStockData(String symbol){
  try{
    String[] alldata = loadStrings("stockdata/" + symbol + ".txt");
    
    String[][] formatteddata = new String[alldata.length][6];
    
    for(int i = 0; i < alldata.length; i++){
      formatteddata[i] = alldata[i].split(",");
    }
    
    return formatteddata;
  }
  catch(NullPointerException e){
    return new String[0][0];
  }
}
