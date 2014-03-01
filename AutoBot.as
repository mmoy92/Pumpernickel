package {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AutoBot {
		private var command:String;
		private var names:Array = new Array("AAPL", "ATVI", "EA", "FB", "GOOG", "MSFT", "SBUX", "SNY", "TSLA", "TWTR");
		//private var index:int = 0;
		private var tempStock:StockRow_MC;
		private var elimName:Vector.<StockRow_MC>;
		private var diff:Number;
		private var myTimer:Timer;
		
		public function AutoBot() {
			elimName = new Vector.<StockRow_MC>();
			
			myTimer = new Timer(30000);
			myTimer.addEventListener(TimerEvent.TIMER, tryBid);
		
		}
		
		public function startBot():void {
			myTimer.start();
		}
		
		public function stopBot():void {
			myTimer.stop();
		}
		
		private function tryBid(e:TimerEvent):void {
			
			tempStock = findOptimal();
			if (tempStock == null) {
				command = "MY_CASH";
			} else {
				command = "BID " + tempStock.stock + " " + String(Number(tempStock.askPrice) + .2) + " " + "10";
			}
			
			//do
			Main.inst.manager.sendCommand(command);
			Main.inst.dt.post(command);
		}
		
		public function findOptimal():StockRow_MC {
			// only want grater than grade 10 and less than $40 per stock
			for (var i:int = 0; i < 10; i++) {
				tempStock = Main.inst.sm.getStockRowByName(names[i]);
				trace(tempStock);
				if (tempStock.grade > 10 && tempStock.askPrice < 40.00) {
					elimName.push(tempStock);
				}
			}
			trace(elimName);
			if (elimName.length == 0) {
				return null;
			}
			
			// buy only if price different between BID and ASK is low
			tempStock = elimName[0];
			diff = elimName[0].askPrice - elimName[0].bidPrice;
			if (elimName.length == 1) {
				return tempStock;
			}
			for (var s:int = 1; s < elimName.length; s++) {
				if (diff > (elimName[s].askPrice - elimName[s].bidPrice)) {
					tempStock = elimName[s];
				}
			}
			return tempStock;
		}
	
	}

}