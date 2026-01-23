//parent indicator class, no functionality
class Indicator {
  int signal(Candle[] data) {
    return 0;
  }
  String info() {
    return "";
  }
}

/*
Stochastic Oscillator
-----------------------------------
momentum indicator
in a certain period, calculates highest high, lowest low
compares current close price to calculated prices
return a percentage, higher percent = overbought, lower percent = oversold / underbought
*/
class STOCHOSC extends Indicator {
  int lastSignal;
  int period;
  float overbought;
  float underbought;
  
  //period, overbought threshold, oversold threshold, last signal is used for signalling
  STOCHOSC(int per, float over, float under) {
    this.period = per;
    this.overbought = over;
    this.underbought = under;
    this.lastSignal = 0;
  }
  
  //return info
  String info() {
    return "Stochastic Oscillator " + this.period + " day average, " + this.overbought + " over, " + this.underbought + " under";
  }
  
  //signal function returns an integer -2 <= n <= 2
  int signal(Candle[] data) {
    
    //check if there is enough data to signal
    if (data.length <= this.period) {
      return 0;
    }
    
    else {
      //get max high and min low from time period
      float maxHigh = data[data.length-1].high;
      float minLow = data[data.length-1].low;

      for (int i = data.length - this.period; i < data.length; i++) {
        if (data[i].high > maxHigh) {
          maxHigh = data[i].high;
        }
        if (data[i].low < minLow) {
          minLow = data[i].low;
        }
      }
      
      //calculate %K, which indicates momentum
      float percentK;
      if (maxHigh - minLow == 0) { //prevents divide by 0
        percentK = 100;
      }
      
      else { //formula for calculating %K
        percentK = 100 * (data[data.length-1].close - minLow) / (maxHigh - minLow);
      }
      
      /*
      prediction logic
      -------------------------
      This is the actual output of the signal
      prediction < 0 means sell indicator, prediction > 0 means buy, prediction = 0 means neutral/do nothing
      2 or -2 means signal just flipped to buy/sell
      1 or -1 means signal is buy/sell but last signal was also the same
      */
      int prediction = 0;

      if (percentK > this.overbought) { //overbought
        prediction = 1;
      } else if (percentK < this.underbought) { //underbought
        prediction = -1;
      }

      if (this.lastSignal == 0) { //if last signal was do nothing, return a flip
        lastSignal = prediction * 2;
        return prediction * 2;
      }
      else {
        if (prediction * this.lastSignal < 0) { //if signal is opposite direction of last signal, return a flip
          lastSignal = prediction;
          return prediction * 2;
        }
        else { //no flip
          lastSignal = prediction;
          return prediction;
        }
      }
    }
  }
}

/*
Relative Strength Index
-----------------------------------
momentum indicator
in a certain period, averages daily gains and losses
outputs a number between 0 and 100, larger number is overbought, smaller is underbought
*/
class RSI extends Indicator {
  int lastSignal;
  int period;
  float overbought;
  float underbought;

  //initialize period, overbought threshold, underbought threshold
  RSI(int per, float over, float under) {
    this.period = per;
    this.overbought = over;
    this.underbought = under;
    this.lastSignal = 0;
  }

  String info() {
    return "RSI " + this.period + " day average, " + this.overbought + " over, " + this.underbought + " under";
  }

  //signal function
  int signal(Candle[] data) {

    //check if enough data to signal
    if (data.length <= this.period) {
      return 0;
    }
    else {
      //computes average gain and loss
      float gains = 0;
      float losses = 0;

      for (int i = data.length - this.period; i < data.length; i++) {
        float change = data[i].close - data[i-1].close;

        if (change < 0) {
          losses += -change;
        } else {
          gains += change;
        }
      }

      float averageGain = gains / this.period;
      float averageLoss = losses / this.period;

      //calculates RSI using formula
      float rsi;
      if (averageLoss == 0) { //prevents divide by 0
        rsi = 100;
      } else { //real formula
        rsi = 100 - 100 / (1 + averageGain / averageLoss);
      }
      
      /*
      prediction logic
      -------------------------
      This is the actual output of the signal
      prediction < 0 means sell indicator, prediction > 0 means buy, prediction = 0 means neutral/do nothing
      2 or -2 means signal just flipped to buy/sell
      1 or -1 means signal is buy/sell but last signal was also the same
      */
      int prediction = 0;

      if (rsi > this.overbought) {
        prediction = 1;
      } else if (rsi < this.underbought) {
        prediction = -1;
      }

      if (this.lastSignal == 0) { //flip
        lastSignal = prediction * 2;
        return prediction * 2;
      } else {
        if (prediction * this.lastSignal < 0) { //flip
          lastSignal = prediction;
          return prediction * 2;
        } else { //no flip
          lastSignal = prediction;
          return prediction;
        }
      }
    }
  }
}

/*
Moving Average Convergence Divergence
-------------------------------------
Momentum indicator
calculates long and short moving averages
when short goes above long, more momentum -> buy
when short goes under long, less momentum -> sell
*/
class MACD extends Indicator {
  int shortRange;
  int longRange;
  int lastSignal;
  
  //initialize short and long ranges
  MACD(int s, int l) {
    this.shortRange = s;
    this.longRange = l;
    this.lastSignal = 0;
  }
  
  //info function
  String info() {
    return "MACD " + this.shortRange + " short, " + this.longRange + " long";
  }
  
  //signal function
  int signal(Candle[] data) {

    //check for data length validity
    if (data.length < longRange) {
      return 0;
    } else {
      //calculate short and long averages by close price
      int prediction;

      float shortAverage = getAveragePrice(data, "close", -shortRange, -1);
      float longAverage = getAveragePrice(data, "close", -longRange, -1);
      
      
      /*
      prediction logic
      -------------------------
      This is the actual output of the signal
      prediction < 0 means sell indicator, prediction > 0 means buy, prediction = 0 means neutral/do nothing
      2 or -2 means signal just flipped to buy/sell
      1 or -1 means signal is buy/sell but last signal was also the same
      */
      if (shortAverage > longAverage) {
        prediction = 1;
      } else {
        prediction = -1;
      }

      if (this.lastSignal == 0) { //flip
        lastSignal = prediction * 2;
        return prediction * 2;
      } else {
        if (prediction * this.lastSignal < 0) { //flip
          lastSignal = prediction;
          return prediction * 2;
        } else { //no flip
          lastSignal = prediction;
          return prediction;
        }
      }
    }
  }
}
