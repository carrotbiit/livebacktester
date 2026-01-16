class Indicator{
  int signal(Candle[] data){
    return 0;
  }
}


class MACD extends Indicator{
  int shortRange;
  int longRange;
  int lastSignal;
  
  MACD(int s, int l){
    this.shortRange = s;
    this.longRange = l;
    this.lastSignal = -2;
  }
  
  int signal(Candle[] data){
    
    
    if (data.length < longRange){
      return 0;
    }
    else{
      int prediction;
      
      float shortAverage = getAveragePrice(data, "close", -shortRange, -1);
      float longAverage = getAveragePrice(data, "close", -longRange, -1);
      
      if (shortAverage > longAverage){
        prediction = 1;
      }
      else{
        prediction = -1;
      }
      
      if (lastSignal == -2){
        lastSignal = prediction;
        return prediction;
      }
      else{
        if (prediction == -lastSignal){
          lastSignal = prediction;
          return prediction;
        }
        else{
          return 0;
        }
      }
    }
  }
}
