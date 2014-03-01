package {
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Michael Moy
	 */
	public class StockRowManager {
		public var AAPL:StockRow_MC;
		public var ATVI:StockRow_MC;
		public var EA:StockRow_MC;
		public var FB:StockRow_MC;
		public var GOOG:StockRow_MC;
		public var MSFT:StockRow_MC;
		public var SBUX:StockRow_MC;
		public var SNY:StockRow_MC;
		public var TSLA:StockRow_MC;
		public var TWTR:StockRow_MC;
		
		public var netWorthTxt:TextField;
		
		private var allStockRows:Vector.<StockRow_MC>;
		public var maxWorth:Number;
		
		public function StockRowManager() {
			maxWorth = 0;
			allStockRows = new Vector.<StockRow_MC>();
			
			AAPL = StockRow_MC(Main.inst.getChildByName("stock_AAPL"));
			ATVI = StockRow_MC(Main.inst.getChildByName("stock_ATVI"));
			EA = StockRow_MC(Main.inst.getChildByName("stock_EA"));
			FB = StockRow_MC(Main.inst.getChildByName("stock_FB"));
			GOOG = StockRow_MC(Main.inst.getChildByName("stock_GOOG"));
			MSFT = StockRow_MC(Main.inst.getChildByName("stock_MSFT"));
			SBUX = StockRow_MC(Main.inst.getChildByName("stock_SBUX"));
			SNY = StockRow_MC(Main.inst.getChildByName("stock_SNY"));
			TSLA = StockRow_MC(Main.inst.getChildByName("stock_TSLA"));
			TWTR = StockRow_MC(Main.inst.getChildByName("stock_TWTR"));
			
			allStockRows.push(AAPL, ATVI, EA, FB, GOOG, MSFT, SBUX, SNY, TSLA, TWTR);
			
			netWorthTxt = TextField(Main.inst.getChildByName("netCash_TXT"));
		
		}
		
		public function updateBars():void {
			
			for each (var stockRow:StockRow_MC in allStockRows) {
				stockRow.updateBar();
			}
		}
		
		public function updateDisplay():void {
			var totalWorth:Number = Main.inst.dt.cash;
			
			for each (var stockRow:StockRow_MC in allStockRows) {
				totalWorth += stockRow.stockAmt * stockRow.askPrice;
			}
			if (!isNaN(totalWorth)) {
				netWorthTxt.text = totalWorth.toString();
			}
		}
		
		public function getStockRowByName(str:String):StockRow_MC {
			if (str == "AAPL") {
				return AAPL;
			} else if (str == "ATVI") {
				return ATVI;
			} else if (str == "EA") {
				return EA;
			} else if (str == "FB") {
				return FB;
			} else if (str == "GOOG") {
				return GOOG;
			} else if (str == "MSFT") {
				return MSFT;
			} else if (str == "SBUX") {
				return SBUX;
			} else if (str == "SNY") {
				return SNY;
			} else if (str == "TSLA") {
				return TSLA;
			} else if (str == "TWTR") {
				return TWTR;
			} else {
				return null;
			}
		}
	
	}

}