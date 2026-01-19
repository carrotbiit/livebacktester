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
    this.lastSignal = 0;
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
      
      //first ever signal
      if (this.lastSignal == 0){
        lastSignal = prediction;
        return prediction;
      }
      
      else{
        if (prediction * this.lastSignal < 0){ //flip
          lastSignal = prediction;
          return prediction * 2;
        }
        else{ //no flip
          lastSignal = prediction;
          return prediction;
        }
      }
    }
  }
}
