package  
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author Michael Moy
	 */
	public class StockRowManager 
	{
		public const AAPL:StockRow_MC;
		public const ATVI:StockRow_MC;
		public const EA:StockRow_MC;
		public const FB:StockRow_MC;
		public const GOOG:StockRow_MC;
		public const MFST:StockRow_MC;
		public const SBUX:StockRow_MC;
		public const SNY:StockRow_MC;
		public const TSLA:StockRow_MC;
		public const TWTR:StockRow_MC;
		
		public function StockRowManager(stage:Stage) 
		{
			AAPL = StockRow_MC(stage.getChildByName("stock_AAPL"));
			ATVI = StockRow_MC(stage.getChildByName("stock_ATVI"));
			EA = StockRow_MC(stage.getChildByName("stock_EA"));
			FB = StockRow_MC(stage.getChildByName("stock_FB"));
			GOOG = StockRow_MC(stage.getChildByName("stock_GOOG"));
			MFST = StockRow_MC(stage.getChildByName("stock_MFST"));
			SBUX = StockRow_MC(stage.getChildByName("stock_SBUX"));
			SNY = StockRow_MC(stage.getChildByName("stock_SNY"));
			TSLA = StockRow_MC(stage.getChildByName("stock_TSLA"));
			TWTR = StockRow_MC(stage.getChildByName("stock_TWTR"));
		}
		
	}

}