class Indicator{
  int signal(Candle[] data){
    return 0;
  }
  String info(){
    return "";
  }
}

class RSI extends Indicator{
  int lastSignal;
  int period;
  float overbought;
  float underbought;
  String type = "RSI";
  
  RSI(int per, float over, float under){
    this.period = per;
    this.overbought = over;
    this.underbought = under;
    this.lastSignal = 0;
  }
  
  String info(){
    return "RSI " + this.period + " day average, " + this.overbought + " over, " + this.underbought + " under";
  }
  
  int signal(Candle[] data){
    
    if (data.length <= this.period){
      return 0;
    }
    
    else {
      //get prediction (buy or sell)
      float gains = 0;
      float losses = 0;
      
      for (int i = data.length - this.period; i < data.length; i++){
        float change = data[i].close - data[i-1].close;
        
        if (change < 0){
          losses += -change;
        }
        else{
          gains += change;
        }
      }
      
      float averageGain = gains / this.period;
      float averageLoss = losses / this.period;
      
      float rsi;
      if (averageLoss == 0){
        rsi = 100;
      }
      else {
        rsi = 100 - 100 / (1 + averageGain / averageLoss);
      }
      
      int prediction = 0;
      
      if (rsi > this.overbought){
        prediction = 1;
      }
      else if (rsi < this.underbought){
        prediction = -1;
      }
      
      //return buy or sell if signal is up or down and last signal was do nothing
      if (this.lastSignal == 0){
        lastSignal = prediction * 2;
        return prediction * 2;
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


class MACD extends Indicator{
  int shortRange;
  int longRange;
  int lastSignal;
  
  MACD(int s, int l){
    this.shortRange = s;
    this.longRange = l;
    this.lastSignal = 0;
  }
  
  String info(){
    return "MACD " + this.shortRange + " short, " + this.longRange + " long";
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
        lastSignal = prediction * 2;
        return prediction * 2;
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
