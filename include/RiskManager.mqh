//+------------------------------------------------------------------+ //| Custom Risk Management Class | //+------------------------------------------------------------------+ class CRiskManager { public: double CalculateLotSize(double riskPercent, int stopLossPoints) { double balance = AccountInfoDouble(ACCOUNT_BALANCE); double tickValue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE); if(stopLossPoints <= 0) return 0.01;

    double lot = (balance * (riskPercent / 100)) / (stopLossPoints * tickValue);
    return NormalizeDouble(lot, 2);
}


};