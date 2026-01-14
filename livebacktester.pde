import self.tekichan.demo.yfinance4j.*;
import self.tekichan.demo.yfinance4j.ctrl.*;
import self.tekichan.demo.yfinance4j.model.*;
import java.time.*;
import java.util.*;

LocalDate startTime = LocalDate.of(2015, 1, 1);
LocalDate endTime = LocalDate.of(2015, 1, 30);
Interval timeInterval = Interval.DAILY;
String tickerSymbol = "TSLA";

HistoricalQuoteCtrl ctrl = new HistoricalQuoteCtrl();


void setup(){
  ctrl.endDate(endTime);
  ctrl.startDate(startTime);
  ctrl.interval(timeInterval);
  ctrl.symbol(tickerSymbol);
  
  List<HistoricalQuote> info = ctrl.getHistoricalData();
  
  println(info);
  
  exit();
}
