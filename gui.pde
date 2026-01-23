/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void editStrategyButtonClicked(GButton source, GEvent event) { //_CODE_:editStrategyButton:674897:
  strategyWindow.setVisible(true);
} //_CODE_:editStrategyButton:674897:

public void saveToFileButtonClicked(GButton source, GEvent event) { //_CODE_:saveToFileButton:917555:
  println("saveToFileButton - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:saveToFileButton:917555:

public void loadFromFileButtonClicked(GButton source, GEvent event) { //_CODE_:loadFromFileButton:656000:
  println("loadFromFileButton - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:loadFromFileButton:656000:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:389241:
  if (paused){
    loop();
  }
  else{
    noLoop();
  }
  
  paused = !paused;
} //_CODE_:pauseButton:389241:

public void tickerFieldChanged(GTextField source, GEvent event) { //_CODE_:tickerField:957004:
  println("tickerField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:tickerField:957004:

public void startDateFieldChanged(GTextField source, GEvent event) { //_CODE_:startDateField:916137:
  println("startDateField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:startDateField:916137:

public void endDateFieldChanged(GTextField source, GEvent event) { //_CODE_:endDateField:865053:
  println("endDateField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:endDateField:865053:

public void goButtonClicked(GButton source, GEvent event) { //_CODE_:goButton:294209:
  String startDate = startDateField.getText();
  String endDate = endDateField.getText();
  String tickerSymbol = tickerField.getText();
  
  if (indicators.size() < 1){
    warning("Need at least 1 indicator in trading strategy");
  }
  else if (!checkValidSymbol(tickerSymbol)){
    warning("Ticker symbol not valid (only S&P 500 stocks)");
  }
  else if (endDate.compareTo(startDate) <= 0 || !isValidDate(startDate) || !isValidDate(endDate)){
    warning("Enter a valid time period");
  }
  else{
    Tester tester = new Tester(indicators, tickerSymbol, startDate, endDate);
    graph.tester = tester;
    runningSim = true;
    openLong = false;
    openShort = false;
    loop();
  }
} //_CODE_:goButton:294209:

synchronized public void drawStrategyWindow(PApplet appc, GWinData data) { //_CODE_:strategyWindow:761041:
  appc.background(230);
} //_CODE_:strategyWindow:761041:

public void addButtonClicked(GButton source, GEvent event) { //_CODE_:addButton:621949:
  addStrategy.setVisible(true);
  
} //_CODE_:addButton:621949:

public void closeStrategyWindowClicked(GButton source, GEvent event) { //_CODE_:closeStrategyWindow:548341:
  addStrategy.setVisible(false);
  removeStrategyWindow.setVisible(false);
  strategyWindow.setVisible(false);
} //_CODE_:closeStrategyWindow:548341:

public void removeButtonClicked(GButton source, GEvent event) { //_CODE_:removeButton:772442:
  removeStrategyWindow.setVisible(true);
} //_CODE_:removeButton:772442:

synchronized public void drawAddStrategy(PApplet appc, GWinData data) { //_CODE_:addStrategy:708744:
  appc.background(230);
} //_CODE_:addStrategy:708744:

public void strategyListClicked(GDropList source, GEvent event) { //_CODE_:strategyList:709875:
  println("strategyList - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:strategyList:709875:

public void okButtonAddClicked(GButton source, GEvent event) { //_CODE_:okButtonAdd:997103:
  String dropOption = strategyList.getSelectedText();
  
  if (dropOption.equals("MACD")){
    MACDWindow.setVisible(true);
  }
  else if (dropOption.equals("RSI")){
    RSIWindow.setVisible(true);
  }
  else if (dropOption.equals("STOCH OSC")){
    stochoscWindow.setVisible(true);
  }
  
  addStrategy.setVisible(false);
} //_CODE_:okButtonAdd:997103:

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:removeStrategyWindow:863519:
  appc.background(230);
} //_CODE_:removeStrategyWindow:863519:

public void removeTextFieldChanged(GTextField source, GEvent event) { //_CODE_:removeTextField:264557:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:removeTextField:264557:

public void okButtonClicked(GButton source, GEvent event) { //_CODE_:okButton:218341:
  String removeIndex = removeTextField.getText();
  try{
    int removeIndexInt = Integer.parseInt(removeIndex);
    if (indicators.size() >= removeIndexInt){
      indicators.remove(removeIndexInt-1);
      updateIndicatorList();
    }
  }
  catch (NumberFormatException e){
    println("invalid");
  }
  removeStrategyWindow.setVisible(false);
  removeTextField.setText("");
} //_CODE_:okButton:218341:

synchronized public void drawMACD(PApplet appc, GWinData data) { //_CODE_:MACDWindow:948439:
  appc.background(230);
} //_CODE_:MACDWindow:948439:

public void textfield2_change1(GTextField source, GEvent event) { //_CODE_:shortAverageText:581796:
  println("shortAverageText - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:shortAverageText:581796:

public void longAverageTextChanged(GTextField source, GEvent event) { //_CODE_:longAverageText:216884:
  println("longAverageText - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:longAverageText:216884:

public void MACDCloseButtonClicked(GButton source, GEvent event) { //_CODE_:MACDCloseButton:911697:
  
  String longAvg = longAverageText.getText();
  String shortAvg = shortAverageText.getText();
  
  boolean isValid = true;
  
  try{
    if (Integer.parseInt(longAvg) <= Integer.parseInt(shortAvg)){
      isValid = false;
    }
  }
  catch (NumberFormatException e){
    isValid = false;
  }
  
  if (isValid){
    indicators.add(new MACD(Integer.parseInt(shortAvg), Integer.parseInt(longAvg)));
    updateIndicatorList();
  }
  longAverageText.setText("200");
  shortAverageText.setText("50");
  MACDWindow.setVisible(false);
} //_CODE_:MACDCloseButton:911697:

public void MACDCancelButtonClicked(GButton source, GEvent event) { //_CODE_:MACDCancelButton:872976:
  longAverageText.setText("200");
  shortAverageText.setText("50");
  MACDWindow.setVisible(false);
} //_CODE_:MACDCancelButton:872976:

synchronized public void drawRSIwindow(PApplet appc, GWinData data) { //_CODE_:RSIWindow:816829:
  appc.background(230);
} //_CODE_:RSIWindow:816829:

public void timePeriodFieldChanged(GTextField source, GEvent event) { //_CODE_:timePeriodField:479113:
  println("timePeriodField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:timePeriodField:479113:

public void overTextFieldChanged(GTextField source, GEvent event) { //_CODE_:overTextField:676199:
  println("overTextField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:overTextField:676199:

public void underTextFieldChanged(GTextField source, GEvent event) { //_CODE_:underTextField:794880:
  println("underTextField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:underTextField:794880:

public void okRSIClicked(GButton source, GEvent event) { //_CODE_:okRSI:903525:
  String timePeriod = timePeriodField.getText();
  String over = overTextField.getText();
  String under = underTextField.getText();
  
  boolean isValid = true;
  
  int timePeriodInt = 0;
  float overFloat = 0;
  float underFloat = 0;
  try{
    timePeriodInt = Integer.parseInt(timePeriod);
    overFloat = Float.parseFloat(over);
    underFloat = Float.parseFloat(under);
    if (timePeriodInt <= 0 || overFloat < underFloat || overFloat > 100 || underFloat > 100 || overFloat < 0 || underFloat < 0){
      isValid = false;
    }
  }
  catch (NumberFormatException e){
    isValid = false;
  }
  
  if (isValid){
    indicators.add(new RSI(timePeriodInt, overFloat, underFloat));
    updateIndicatorList();
  }
  timePeriodField.setText("14");
  overTextField.setText("70");
  underTextField.setText("30");
  RSIWindow.setVisible(false);
} //_CODE_:okRSI:903525:

public void cancelRSIClicked(GButton source, GEvent event) { //_CODE_:cancelRSI:902654:
  println("cancelRSI - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:cancelRSI:902654:

synchronized public void warning_draw1(PApplet appc, GWinData data) { //_CODE_:warningWindow:802076:
  appc.background(230);
} //_CODE_:warningWindow:802076:

public void okWarningClicked(GButton source, GEvent event) { //_CODE_:okWarning:794722:
  warningWindow.setVisible(false);
} //_CODE_:okWarning:794722:

synchronized public void stochoscdraw1(PApplet appc, GWinData data) { //_CODE_:stochoscWindow:766293:
  appc.background(230);
} //_CODE_:stochoscWindow:766293:

public void stochoscPeriodChanged(GTextField source, GEvent event) { //_CODE_:stochoscPeriod:373662:
  println("stochoscPeriod - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:stochoscPeriod:373662:

public void stochoscOverChanged(GTextField source, GEvent event) { //_CODE_:stochoscOver:918657:
  println("stochoscOver - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:stochoscOver:918657:

public void stochoscUnderChanged(GTextField source, GEvent event) { //_CODE_:stochoscUnder:793984:
  println("stochoscUnder - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:stochoscUnder:793984:

public void stochoscCloseClicked(GButton source, GEvent event) { //_CODE_:stochoscClose:670116:
  String timePeriod = stochoscPeriod.getText();
  String over = stochoscOver.getText();
  String under = stochoscUnder.getText();
  
  boolean isValid = true;
  
  int timePeriodInt = 0;
  float overFloat = 0;
  float underFloat = 0;
  try{
    timePeriodInt = Integer.parseInt(timePeriod);
    overFloat = Float.parseFloat(over);
    underFloat = Float.parseFloat(under);
    if (timePeriodInt <= 0 || overFloat < underFloat || overFloat > 100 || underFloat > 100 || overFloat < 0 || underFloat < 0){
      isValid = false;
    }
  }
  catch (NumberFormatException e){
    isValid = false;
  }
  
  if (isValid){
    indicators.add(new STOCHOSC(timePeriodInt, overFloat, underFloat));
    updateIndicatorList();
  }
  timePeriodField.setText("14");
  overTextField.setText("80");
  underTextField.setText("20");
  stochoscWindow.setVisible(false);
} //_CODE_:stochoscClose:670116:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Live Backtester");
  editStrategyButton = new GButton(this, 10, 10, 100, 35);
  editStrategyButton.setText("Edit Strategy");
  editStrategyButton.addEventHandler(this, "editStrategyButtonClicked");
  saveToFileButton = new GButton(this, 120, 10, 100, 35);
  saveToFileButton.setText("Save to File");
  saveToFileButton.addEventHandler(this, "saveToFileButtonClicked");
  loadFromFileButton = new GButton(this, 230, 10, 100, 35);
  loadFromFileButton.setText("Load from File");
  loadFromFileButton.addEventHandler(this, "loadFromFileButtonClicked");
  pauseButton = new GButton(this, 340, 10, 100, 35);
  pauseButton.setText("Pause/Unpause");
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  label13 = new GLabel(this, 450, 3, 92, 20);
  label13.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label13.setText("Ticker Symbol");
  label13.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label13.setOpaque(false);
  tickerField = new GTextField(this, 450, 26, 93, 22, G4P.SCROLLBARS_NONE);
  tickerField.setText("AAPL");
  tickerField.setOpaque(true);
  tickerField.addEventHandler(this, "tickerFieldChanged");
  label14 = new GLabel(this, 550, 3, 92, 20);
  label14.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label14.setText("Start Date");
  label14.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label14.setOpaque(false);
  startDateField = new GTextField(this, 550, 26, 93, 22, G4P.SCROLLBARS_NONE);
  startDateField.setPromptText("YYYY-MM-DD");
  startDateField.setOpaque(true);
  startDateField.addEventHandler(this, "startDateFieldChanged");
  label15 = new GLabel(this, 649, 3, 92, 20);
  label15.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label15.setText("End Date");
  label15.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label15.setOpaque(false);
  endDateField = new GTextField(this, 649, 26, 93, 22, G4P.SCROLLBARS_NONE);
  endDateField.setPromptText("YYYY-MM-DD");
  endDateField.setOpaque(true);
  endDateField.addEventHandler(this, "endDateFieldChanged");
  goButton = new GButton(this, 747, 10, 42, 35);
  goButton.setText("Start");
  goButton.addEventHandler(this, "goButtonClicked");
  strategyWindow = GWindow.getWindow(this, "Edit Strategy", 160, 100, 300, 300, JAVA2D);
  strategyWindow.noLoop();
  strategyWindow.setActionOnClose(G4P.KEEP_OPEN);
  strategyWindow.addDrawHandler(this, "drawStrategyWindow");
  addButton = new GButton(strategyWindow, 5, 36, 65, 30);
  addButton.setText("Add");
  addButton.addEventHandler(this, "addButtonClicked");
  closeStrategyWindow = new GButton(strategyWindow, 240, 265, 50, 25);
  closeStrategyWindow.setText("Close");
  closeStrategyWindow.addEventHandler(this, "closeStrategyWindowClicked");
  strategyWindowTitle = new GLabel(strategyWindow, 0, 1, 96, 30);
  strategyWindowTitle.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  strategyWindowTitle.setText("My Strategy");
  strategyWindowTitle.setOpaque(false);
  strategyText = new GLabel(strategyWindow, 5, 76, 286, 177);
  strategyText.setTextAlign(GAlign.LEFT, GAlign.TOP);
  strategyText.setOpaque(false);
  removeButton = new GButton(strategyWindow, 76, 36, 65, 30);
  removeButton.setText("Remove");
  removeButton.addEventHandler(this, "removeButtonClicked");
  addStrategy = GWindow.getWindow(this, "Add Strategy", 0, 0, 150, 150, JAVA2D);
  addStrategy.noLoop();
  addStrategy.setActionOnClose(G4P.KEEP_OPEN);
  addStrategy.addDrawHandler(this, "drawAddStrategy");
  label4 = new GLabel(addStrategy, 4, 4, 80, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Add Strategy");
  label4.setOpaque(false);
  strategyList = new GDropList(addStrategy, 5, 32, 90, 80, 3, 10);
  strategyList.setItems(loadStrings("list_709875"), 0);
  strategyList.addEventHandler(this, "strategyListClicked");
  okButtonAdd = new GButton(addStrategy, 97, 111, 46, 30);
  okButtonAdd.setText("ok");
  okButtonAdd.addEventHandler(this, "okButtonAddClicked");
  removeStrategyWindow = GWindow.getWindow(this, "Remove Strategy", 0, 200, 150, 150, JAVA2D);
  removeStrategyWindow.noLoop();
  removeStrategyWindow.setActionOnClose(G4P.KEEP_OPEN);
  removeStrategyWindow.addDrawHandler(this, "win_draw1");
  label1 = new GLabel(removeStrategyWindow, 1, 1, 120, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Remove Strategy");
  label1.setOpaque(false);
  label2 = new GLabel(removeStrategyWindow, 0, 32, 144, 30);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Type which number on list you want to remove");
  label2.setOpaque(false);
  removeTextField = new GTextField(removeStrategyWindow, 2, 66, 103, 30, G4P.SCROLLBARS_NONE);
  removeTextField.setOpaque(true);
  removeTextField.addEventHandler(this, "removeTextFieldChanged");
  okButton = new GButton(removeStrategyWindow, 107, 66, 38, 30);
  okButton.setText("ok");
  okButton.addEventHandler(this, "okButtonClicked");
  MACDWindow = GWindow.getWindow(this, "MACD", 0, 0, 150, 150, JAVA2D);
  MACDWindow.noLoop();
  MACDWindow.setActionOnClose(G4P.KEEP_OPEN);
  MACDWindow.addDrawHandler(this, "drawMACD");
  addMACDLabel = new GLabel(MACDWindow, 5, 5, 80, 20);
  addMACDLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  addMACDLabel.setText("New MACD");
  addMACDLabel.setOpaque(false);
  label5 = new GLabel(MACDWindow, 5, 28, 94, 20);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Short Average:");
  label5.setOpaque(false);
  label6 = new GLabel(MACDWindow, 5, 72, 101, 20);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Long Average:");
  label6.setOpaque(false);
  shortAverageText = new GTextField(MACDWindow, 5, 48, 75, 20, G4P.SCROLLBARS_NONE);
  shortAverageText.setText("50");
  shortAverageText.setOpaque(true);
  shortAverageText.addEventHandler(this, "textfield2_change1");
  label7 = new GLabel(MACDWindow, 80, 48, 61, 20);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("days");
  label7.setOpaque(false);
  longAverageText = new GTextField(MACDWindow, 5, 95, 75, 20, G4P.SCROLLBARS_NONE);
  longAverageText.setText("200");
  longAverageText.setOpaque(true);
  longAverageText.addEventHandler(this, "longAverageTextChanged");
  label8 = new GLabel(MACDWindow, 80, 95, 61, 20);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("days");
  label8.setOpaque(false);
  MACDCloseButton = new GButton(MACDWindow, 112, 124, 34, 22);
  MACDCloseButton.setText("ok");
  MACDCloseButton.addEventHandler(this, "MACDCloseButtonClicked");
  MACDCancelButton = new GButton(MACDWindow, 62, 124, 47, 22);
  MACDCancelButton.setText("cancel");
  MACDCancelButton.addEventHandler(this, "MACDCancelButtonClicked");
  RSIWindow = GWindow.getWindow(this, "RSI", 0, 0, 150, 180, JAVA2D);
  RSIWindow.noLoop();
  RSIWindow.setActionOnClose(G4P.KEEP_OPEN);
  RSIWindow.addDrawHandler(this, "drawRSIwindow");
  label3 = new GLabel(RSIWindow, 5, 2, 80, 22);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("New RSI");
  label3.setOpaque(false);
  label9 = new GLabel(RSIWindow, 5, 24, 80, 20);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Time Period");
  label9.setOpaque(false);
  timePeriodField = new GTextField(RSIWindow, 5, 46, 60, 20, G4P.SCROLLBARS_NONE);
  timePeriodField.setText("14");
  timePeriodField.setOpaque(true);
  timePeriodField.addEventHandler(this, "timePeriodFieldChanged");
  label10 = new GLabel(RSIWindow, 66, 46, 41, 20);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("days");
  label10.setOpaque(false);
  label11 = new GLabel(RSIWindow, 5, 67, 130, 20);
  label11.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label11.setText("Overbought Threshold");
  label11.setOpaque(false);
  overTextField = new GTextField(RSIWindow, 5, 88, 60, 20, G4P.SCROLLBARS_NONE);
  overTextField.setText("70");
  overTextField.setOpaque(true);
  overTextField.addEventHandler(this, "overTextFieldChanged");
  label12 = new GLabel(RSIWindow, 5, 108, 141, 20);
  label12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label12.setText("Underbought Threshold");
  label12.setOpaque(false);
  underTextField = new GTextField(RSIWindow, 5, 129, 60, 20, G4P.SCROLLBARS_NONE);
  underTextField.setText("30");
  underTextField.setOpaque(true);
  underTextField.addEventHandler(this, "underTextFieldChanged");
  okRSI = new GButton(RSIWindow, 115, 150, 30, 21);
  okRSI.setText("ok");
  okRSI.addEventHandler(this, "okRSIClicked");
  cancelRSI = new GButton(RSIWindow, 63, 150, 49, 21);
  cancelRSI.setText("cancel");
  cancelRSI.addEventHandler(this, "cancelRSIClicked");
  warningWindow = GWindow.getWindow(this, "Warning", 600, 400, 150, 150, JAVA2D);
  warningWindow.noLoop();
  warningWindow.setActionOnClose(G4P.KEEP_OPEN);
  warningWindow.addDrawHandler(this, "warning_draw1");
  warningLabel = new GLabel(warningWindow, 1, 0, 145, 120);
  warningLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  warningLabel.setText("My label");
  warningLabel.setOpaque(false);
  okWarning = new GButton(warningWindow, 117, 122, 28, 22);
  okWarning.setText("ok");
  okWarning.addEventHandler(this, "okWarningClicked");
  stochoscWindow = GWindow.getWindow(this, "STOCHOSC", 0, 0, 150, 180, JAVA2D);
  stochoscWindow.noLoop();
  stochoscWindow.setActionOnClose(G4P.KEEP_OPEN);
  stochoscWindow.addDrawHandler(this, "stochoscdraw1");
  label16 = new GLabel(stochoscWindow, 0, 1, 148, 20);
  label16.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label16.setText("New Stochastic Oscillator");
  label16.setOpaque(false);
  stochoscPeriod = new GTextField(stochoscWindow, 1, 43, 89, 22, G4P.SCROLLBARS_NONE);
  stochoscPeriod.setText("14");
  stochoscPeriod.setOpaque(true);
  stochoscPeriod.addEventHandler(this, "stochoscPeriodChanged");
  label17 = new GLabel(stochoscWindow, 1, 22, 80, 20);
  label17.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label17.setText("Time Period");
  label17.setOpaque(false);
  label18 = new GLabel(stochoscWindow, 90, 44, 39, 20);
  label18.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label18.setText("days");
  label18.setOpaque(false);
  label19 = new GLabel(stochoscWindow, 0, 66, 131, 20);
  label19.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label19.setText("Overbought Threshold");
  label19.setOpaque(false);
  stochoscOver = new GTextField(stochoscWindow, 1, 87, 89, 22, G4P.SCROLLBARS_NONE);
  stochoscOver.setText("80");
  stochoscOver.setOpaque(true);
  stochoscOver.addEventHandler(this, "stochoscOverChanged");
  label20 = new GLabel(stochoscWindow, 90, 88, 26, 20);
  label20.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label20.setText("%");
  label20.setOpaque(false);
  label21 = new GLabel(stochoscWindow, 1, 110, 143, 20);
  label21.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label21.setText("Underbought Threshold");
  label21.setOpaque(false);
  stochoscUnder = new GTextField(stochoscWindow, 1, 131, 89, 22, G4P.SCROLLBARS_NONE);
  stochoscUnder.setText("20");
  stochoscUnder.setOpaque(true);
  stochoscUnder.addEventHandler(this, "stochoscUnderChanged");
  label22 = new GLabel(stochoscWindow, 90, 132, 24, 20);
  label22.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label22.setText("%");
  label22.setOpaque(false);
  stochoscClose = new GButton(stochoscWindow, 116, 154, 30, 22);
  stochoscClose.setText("ok");
  stochoscClose.addEventHandler(this, "stochoscCloseClicked");
  strategyWindow.loop();
  addStrategy.loop();
  removeStrategyWindow.loop();
  MACDWindow.loop();
  RSIWindow.loop();
  warningWindow.loop();
  stochoscWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GButton editStrategyButton; 
GButton saveToFileButton; 
GButton loadFromFileButton; 
GButton pauseButton; 
GLabel label13; 
GTextField tickerField; 
GLabel label14; 
GTextField startDateField; 
GLabel label15; 
GTextField endDateField; 
GButton goButton; 
GWindow strategyWindow;
GButton addButton; 
GButton closeStrategyWindow; 
GLabel strategyWindowTitle; 
GLabel strategyText; 
GButton removeButton; 
GWindow addStrategy;
GLabel label4; 
GDropList strategyList; 
GButton okButtonAdd; 
GWindow removeStrategyWindow;
GLabel label1; 
GLabel label2; 
GTextField removeTextField; 
GButton okButton; 
GWindow MACDWindow;
GLabel addMACDLabel; 
GLabel label5; 
GLabel label6; 
GTextField shortAverageText; 
GLabel label7; 
GTextField longAverageText; 
GLabel label8; 
GButton MACDCloseButton; 
GButton MACDCancelButton; 
GWindow RSIWindow;
GLabel label3; 
GLabel label9; 
GTextField timePeriodField; 
GLabel label10; 
GLabel label11; 
GTextField overTextField; 
GLabel label12; 
GTextField underTextField; 
GButton okRSI; 
GButton cancelRSI; 
GWindow warningWindow;
GLabel warningLabel; 
GButton okWarning; 
GWindow stochoscWindow;
GLabel label16; 
GTextField stochoscPeriod; 
GLabel label17; 
GLabel label18; 
GLabel label19; 
GTextField stochoscOver; 
GLabel label20; 
GLabel label21; 
GTextField stochoscUnder; 
GLabel label22; 
GButton stochoscClose; 
