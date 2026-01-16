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
