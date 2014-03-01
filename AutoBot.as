package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class AutoBot 
	{
		private var command:String;
		private var names:Array = new Array("AAPL", "ATVI", "EA", "FB", "GOOG", "MSFT", "SBUX", "SNY", "TSLA", "TWTR");
		//private var index:int = 0;
		private var tempStock:StockRow_MC;
		private var elimName:Vector.<StockRow_MC>;
		private var diff:Number;
		
		public function AutoBot() 
		{
			myTimer = new Timer(30);
			myTimer.addEventListener(TimerEvent.TIMER, tryBid());
			myTimer.start();
			
		}
		
		function tryBid():void {

			
			tempStock = findOptimal();
			if ( tempStock == null) {
				command = "MY_CASH";
			}
			else {
				command = "BID " + tempStock.stock + " " + String(Number(tempStock.askPrice) + .2) + " " + "10";
			}
			
			//do
			Main.inst.manager.sendCommand(command);
		}
		
		function findOptimal():StockRow_MC {
			// only want grater than grade 10 and less than $40 per stock
			for (var i:int = 0; i < 10; i++) {
				tempStock = Main.inst.sm.getStockRowByName(names[i]);
				if (tempStock.grade > 10 && tempStock.askPrice < 40.00) {
					elimName.push(tempStock);
				}
			}
			
			if (elimName.length == 0) {
				return null;
			}
			
			// buy only if price different between BID and ASK is low
			tempStock = elimName[0];
			diff = elimName[0].askPrice - elimName[0].bidPrice;
			if (elimName.length) {
				return tempStock;
			}
			for (var s:int = 1; s < elimName.length; s ++) {
				if (diff > (elimName[s].askPrice - elimName[s].bidPrice)) {
					tempStock = elimIndex[s];
				}
			}
			return tempStock;
		}
		
	}

}