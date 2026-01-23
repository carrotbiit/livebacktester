//checks if ticker symbol is in the stockdata files
boolean checkValidSymbol(String symbol) {
  
  //gets all files in folder
  File folder = new File(sketchPath("stockdata"));
  File[] files = folder.listFiles();
  
  //formats files into string name and checks if tickers symbol is correct
  for (int i = 0; i < files.length; i++) {
    String name = files[i].getName();
    String newname = name.substring(0, name.indexOf("."));
    if (symbol.equals(newname)) {
      return true;
    }
  }
  return false;
}

//checks if a date is formatted corrected
boolean isValidDate(String date) {
  
  //checks correct length of string
  if (date.length() != 10) {
    return false;
  }

  //checks for correct amount of dashes
  int count = 0;
  for (int i = 0; i < date.length(); i++) {
    if (date.charAt(i) == '-') {
      count += 1;
    }
  }
  if (count != 2) {
    return false;
  } 
  
  else {
    //checks if month and day are in range and if they are integers
    String month = date.substring(date.indexOf("-") + 1, date.lastIndexOf("-"));
    String day = date.substring(date.lastIndexOf("-"), date.length());
    
    try{
      if (Integer.parseInt(day) <= 31 && Integer.parseInt(month) <= 12 && Integer.parseInt(day) != 0 && Integer.parseInt(month) != 0) {
        return true;
      } else {
        return false;
      }
    }
    catch (NumberFormatException e){
      return false;
    }
  }
}

//function to open the warning window and set the warning text to input
void warning(String text) {
  warningLabel.setText(text);
  warningWindow.setVisible(true);
}

//updates the list of indicators in my strategy window
void updateIndicatorList() {
  String newText = "";
  
  //iterates through indicators list and puts all the info in an ordered list readable to the user
  int listNum = 1;
  for (Indicator i : indicators) {
    newText += (listNum + ". " + i.info() + "\n");
    listNum += 1;
  }

  strategyText.setText(newText);
}

//gets the maximum volume of a list of data, uses the Candle class
float getMaxVolume(Candle[] data) {
  float max = data[0].volume;
  
  //iterates through the list and finds highest volume number
  for (Candle candle : data) {
    if (candle.volume > max) {
      max = candle.volume;
    }
  }
  return max;
}

//gets maximum high of list of Candles
float getMaxHigh(Candle[] data) {
  float max = data[0].high;
  for (Candle candle : data) {
    if (candle.high > max) {
      max = candle.high;
    }
  }
  return max;
}

//gets mimumum low of a list of Candles
float getMinLow(Candle[] data) {
  float min = data[0].low;
  for (Candle candle : data) {
    if (candle.low < min) {
      min = candle.low;
    }
  }
  return min;
}

//rounding function
float roundAny(float n, int digits) {
  float newn = round(n * pow(10, digits)) / pow(10, digits);
  return newn;
}

//gets average close or open price of a list of Candles
float getAveragePrice(Candle[] data, String column, int start, int end) {
  
  //allows for negative indexing (eg. end = -1 means last index of data)
  int loopstart;
  int loopend;
  
  //checks for negative indexes and properly converts to positive indexes
  if (start < 0) {
    loopstart = data.length + start;
  } else {
    loopstart = start;
  }
  if (end < 0) {
    loopend = data.length + end;
  } else {
    loopend = end;
  }
  
  //totals all prices from range start to end inclusive
  float total = 0;
  int count = 0;
  for (int i = loopstart; i < loopend+1; i++) {
    if (column.equals("open")) {
      total += data[i].open;
    }
    if (column.equals("close")) {
      total += data[i].close;
    }
    count ++;
  }
  
  //returns average
  return total/count;
}

//gets stock data from a file using ticker symbol
Candle[] getStockData(String symbol) {
  
  //check if ticker symbol is in stockdata folder
  try {
    
    //format data to a list of Candles
    String[] alldata = loadStrings("stockdata/" + symbol + ".txt");

    Candle[] formatteddata = new Candle[alldata.length];

    for (int i = 0; i < alldata.length; i++) {
      String[] tempdata = alldata[i].split(",");
      formatteddata[i] = new Candle(tempdata[0], float(tempdata[1]), float(tempdata[2]), float(tempdata[3]), float(tempdata[4]), int(tempdata[5]));
    }

    return formatteddata;
  }
  
  //if not in stockdata folder, return empty list
  catch(NullPointerException e) {
    return new Candle[0];
  }
}

//gets the closest index by date from a list of Candles in ascending date order
int getIndexByDate(Candle[] data, String date) {
  int index = -1;
  for (int i = 0; i < data.length; i++) {
    
    //if dates are the same, return index
    if (data[i].date.equals(date)) {
      return i;
    }
    
    //if date is before target date, keep going
    if (data[i].date.compareTo(date) < 0) {
      index = i;
    }

    //if date is after target date, stop
    if (data[i].date.compareTo(date) > 0) {
      break;
    }
  }
  
  //return the closest date
  return index;
}
