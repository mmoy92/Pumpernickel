package {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class StockRow_MC extends MovieClip {
		public var stock:String;
		
		private var stockAmtTxt:TextField;
		private var stockNameTxt:TextField;
		private var netWorthTxt:TextField;
		private var bar:MovieClip;
		private var askAmtTxt:TextField;
		private var bidAmtTxt:TextField;
		private var dividendTxt:TextField;
		
		public var netWorth:Number;
		
		public function StockRow_MC() {
			stock = name.slice(6);
			
			stockAmtTxt = TextField(getChildByName("stockAmt_TXT"));
			stockNameTxt = TextField(getChildByName("stockName_TXT"));
			netWorthTxt = TextField(getChildByName("networth_TXT"));
			dividendTxt = TextField(getChildByName("dividend_TXT"));
			
			bar = MovieClip(getChildByName("bar_MC"));
			
			askAmtTxt = TextField(getChildByName("ask_TXT"));
			bidAmtTxt = TextField(getChildByName("bid_TXT"));
			
			stockNameTxt.text = stock;
		}
		
		public function updateWorth(i:Number):void {
			if (i > StockRowManager.inst.maxWorth) {
				StockRowManager.inst.maxWorth = i + 5;
			}
			netWorthTxt.text = i.toString();
			netWorth = i;
		}
		
		public function updateDividend(i:Number):void {
			dividendTxt.text = i.toString();
		
		}
		
		public function updateAskBid(ask:Number, bid:Number):void {
			askAmtTxt.text = ask.toString();
			bidAmtTxt.text = bid.toString();
		}
		
		public function updateBar():void {
			bar.scaleX = netWorth / StockRowManager.inst.maxWorth;
			dividendTxt.x = bar.x + bar.width - dividendTxt.textWidth;
		}
	}

}
