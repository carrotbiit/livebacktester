class Tester{
  ArrayList<Indicator> indicators;
  Candle[] data;
  String startDate;
  String endDate;
  String interval;
  
  Tester(ArrayList i, Candle[] d, String s, String e, String intvl){
    indicators = i;
    data = d;
    startDate = s;
    endDate = e;
    interval = intvl;
  }
}
