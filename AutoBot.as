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
		private var diff2:Number;
		private var myTimer:Timer;
		private var myTimer2:Timer;
		
		public function AutoBot() {
			elimName = new Vector.<StockRow_MC>();
			
			myTimer = new Timer(30000);
			myTimer.addEventListener(TimerEvent.TIMER, tryBid);
			
			myTimer2 = new Timer(83000);
			myTimer2.addEventListener(TimerEvent.TIMER, tryAsk);
		
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
				command = "BID " + tempStock.stock + " " + String(Number(tempStock.askPrice) + .4) + " " + "10";
			}
			
			//do
			Main.inst.manager.sendCommand(command);
			Main.inst.dt.post(command);
		}
		
		public function findOptimal():StockRow_MC {
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
			if (elimName.length == 1) {
				return tempStock;
			}
			for (var s:int = 1; s < elimName.length; s++) {
				diff = tempStock.askPrice - tempStock.bidPrice;
				diff2 = elimName[s].askPrice - elimName[s].bidPrice;
				if ((((diff - diff2) < 2.0) || ((tempStock.askPrice - elimName[s].askPrice) < 2.0))  && ((tempStock.netWorth - elimName[s].netWorth) > 500000.0)) {
					//haha
				}
				else if ( diff > diff2 ) {
					tempStock = elimName[s];
				}
			}
			return tempStock;
		}
		
		private function tryAsk(e:TimerEvent):void {
			
			tempStock = sellOptimal();
			if (tempStock == null) {
				command = "MY_CASH";
			} else {
				command = "ASK " + tempStock.stock + " " + String(Number(tempStock.askPrice) - 1) + " " + tempStock.stockAmt;
			}
			
			//do
			Main.inst.manager.sendCommand(command);
			Main.inst.dt.post(command);
		}
		public function sellOptimal():StockRow_MC {
			// only want less than grade 15
			for (var i:int = 0; i < 10; i++) {
				tempStock = Main.inst.sm.getStockRowByName(names[i]);
				if (tempStock.grade < 15 ) {
					elimName.push(tempStock);
				}
			}
			if (elimName.length == 0) {
				return null;
			}
			
			// only 1 stock
			tempStock = elimName[0];
			if (elimName.length == 1) {
				return tempStock;
			}
			
			for (var s:int = 1; s < elimName.length; s++) {
				if ( tempStock.grade > elimName[s].grade) {
					tempStock = elimName[s];
				}
			}
			return tempStock;
		}
	
	}

}