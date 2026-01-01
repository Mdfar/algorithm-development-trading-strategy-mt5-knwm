//+------------------------------------------------------------------+ //| StaqltQuantEA.mq5 | //| Copyright 2026, staqlt Agency | //| https://staqlt.com | //+------------------------------------------------------------------+ #property copyright "Copyright 2026, staqlt" #property link "https://staqlt.com" #property version "1.00" #property strict

// Input parameters input double InpLotSize = 0.1; // Fixed Lot Size input int InpStopLoss = 200; // Stop Loss in Points input int InpTakeProfit = 400; // Take Profit in Points input int InpMagicNumber = 123456; // Magic Number

// Global variables int handleMA;

//+------------------------------------------------------------------+ //| Expert initialization function | //+------------------------------------------------------------------+ int OnInit() { handleMA = iMA(_Symbol, _Period, 14, 0, MODE_SMA, PRICE_CLOSE); if(handleMA == INVALID_HANDLE) return(INIT_FAILED);

Print("Staqlt Quant Engine Initialized."); return(INIT_SUCCEEDED); }

//+------------------------------------------------------------------+ //| Expert tick function | //+------------------------------------------------------------------+ void OnTick() { MqlTradeRequest request={0}; MqlTradeResult result={0};

// Simple Logic: Cross over 14 SMA double maValues[]; CopyBuffer(handleMA, 0, 0, 2, maValues); double lastClose = iClose(_Symbol, _Period, 1);

// Check for open positions to avoid duplicates if(PositionsTotal() < 1) { if(lastClose > maValues[0]) // Buy Signal { request.action = TRADE_ACTION_DEAL; request.symbol = _Symbol; request.volume = InpLotSize; request.type = ORDER_TYPE_BUY; request.price = SymbolInfoDouble(_Symbol, SYMBOL_ASK); request.sl = request.price - InpStopLoss * _Point; request.tp = request.price + InpTakeProfit * _Point; request.magic = InpMagicNumber;

     if(!OrderSend(request, result)) 
        Print("Error opening Buy: ", GetLastError());
  }


} }