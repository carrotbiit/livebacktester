class Candle{
  String date;
  float open;
  float close;
  float high;
  float low;
  int volume;
  
  Candle(Candle candle){
    this.date = candle.date;
    this.open = candle.open;
    this.close = candle.close;
    this.high = candle.high;
    this.low = candle.low;
    this.volume = candle.volume;
  }
  
  
  Candle(String d, float o, float c, float h, float l, int v){
    this.date = d;
    this.open = o;
    this.close = c; 
    this.high = h;
    this.low = l;
    this.volume = v;
  }
  
  
  void printInfo(){
    println(this.date + " " + this.open + " " + this.close + " " + this.high + " " + this.low + " " + this.volume);  
  }
}
