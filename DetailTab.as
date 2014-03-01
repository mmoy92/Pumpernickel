package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	
	public class DetailTab extends MovieClip {
		public var cash:Number = 0;
		
		private var selectedStock:TextField;
		private var yourCurBid:TextField;
		private var yourCurAsk:TextField;
		private var askBtn:SimpleButton;
		private var bidBtn:SimpleButton;
		private var quantIn:TextField;
		private var priceIn:TextField;
		private var cancelAsk:SimpleButton;
		private var cancelBid:SimpleButton;
		private var cashBox:TextField;
		private var offersBtn:SimpleButton;
		private var youroffers:TextField;
		private var isManual:Boolean;
		
		private var yourBidsQuant:Object = new Object();
		private var yourBidsPrice:Object = new Object();
		private var yourAsksQuant:Object = new Object();
		private var yourAsksPrice:Object = new Object();
		
		public function DetailTab() 
		{
			this.stop();
			
			initYourAsks();
			initYourBids();
			
			selectedStock = TextField(this.getChildByName("selectedStock_TXT"));
			yourCurBid = TextField(this.getChildByName("yourBid_TXT"));
			yourCurAsk = TextField(this.getChildByName("yourAsk_TXT"));
			
			quantIn = TextField(this.getChildByName("amountInput_TXT"));
			priceIn = TextField(this.getChildByName("priceInput_TXT"));
			
			askBtn = SimpleButton(this.getChildByName("ask_BTN"));
			bidBtn = SimpleButton(this.getChildByName("bid_BTN"));
			cancelAsk = SimpleButton(this.getChildByName("cancelAsk_BTN"));
			cancelBid = SimpleButton(this.getChildByName("cancelBid_BTN"));
			
			askBtn.addEventListener(MouseEvent.CLICK, onAskClicked);
			bidBtn.addEventListener(MouseEvent.CLICK, onBidClicked);
			cancelAsk.addEventListener(MouseEvent.CLICK, onAskX);
			cancelBid.addEventListener(MouseEvent.CLICK, onBidX);
			
			offersBtn = SimpleButton(this.getChildByName("offers_BTN"));
			offersBtn.addEventListener(MouseEvent.CLICK, onOffersClicked);
			
			this.setCurrentAsk("0 at $0");
			this.setCurrentBid("0 at $0");
			isManual = true;
		}
		
		private function onOffersClicked(event:Event):void
		{
			if (isManual)
			{
				isManual = false;
				this.gotoAndStop(2);
				youroffers = TextField(this.getChildByName("yourOffers_TXT"));
				youroffers.text = "None";
			}
			else
			{
				isManual = true;
				this.gotoAndStop(1);
			}
		}
		
		private function onAskClicked(event:Event):void
		{
			yourAsksQuant[selectedStock.text] = quantIn.text; 
			yourAsksPrice[selectedStock.text] = priceIn.text;
			setCurrentAsk(yourAsksQuant[selectedStock.text] + " at $" + yourAsksPrice[selectedStock.text]);
			sendAskOrder(selectedStock.text, priceIn.text, quantIn.text);
		}
		
		private function onBidClicked(event:Event):void
		{
			yourBidsQuant[selectedStock.text] = quantIn.text;
			yourBidsPrice[selectedStock.text] = priceIn.text;
			setCurrentBid(yourBidsQuant[selectedStock.text] + " at $" + yourBidsPrice[selectedStock.text]);
			sendBidOrder(selectedStock.text, priceIn.text, quantIn.text);
		}
		
		public function onBidX(event:Event):void
		{
			setCurrentBid("0 at $0");
			yourBidsPrice[selectedStock.text] = "0";
			yourBidsQuant[selectedStock.text] = "0";
			NetworkManager(Main.inst.manager).clearBid(selectedStock.text);
		}
		
		public function onAskX(event:Event):void
		{
			setCurrentAsk("0 at $0");
			yourAsksPrice[selectedStock.text] = "0";
			yourAsksQuant[selectedStock.text] = "0";
			NetworkManager(Main.inst.manager).clearAsk(selectedStock.text);
		}
		
		private function initYourBids():void
		{
			yourBidsPrice["AAPL"] = "0";
			yourBidsPrice["ATVI"] = "0";
			yourBidsPrice["EA"] = "0";
			yourBidsPrice["FB"] = "0";
			yourBidsPrice["GOOG"] = "0";
			yourBidsPrice["MSFT"] = "0";
			yourBidsPrice["SBUX"] = "0";
			yourBidsPrice["SNY"] = "0";
			yourBidsPrice["TSLA"] = "0";
			yourBidsPrice["TWTR"] = "0";
			
			yourBidsQuant["AAPL"] = "0";
			yourBidsQuant["ATVI"] = "0";
			yourBidsQuant["EA"] = "0";
			yourBidsQuant["FB"] = "0";
			yourBidsQuant["GOOG"] = "0";
			yourBidsQuant["MSFT"] = "0";
			yourBidsQuant["SBUX"] = "0";
			yourBidsQuant["SNY"] = "0";
			yourBidsQuant["TSLA"] = "0";
			yourBidsQuant["TWTR"] = "0";
		}
		
		private function initYourAsks():void
		{
			yourAsksPrice["AAPL"] = "0";
			yourAsksPrice["ATVI"] = "0";
			yourAsksPrice["EA"] = "0";
			yourAsksPrice["FB"] = "0";
			yourAsksPrice["GOOG"] = "0";
			yourAsksPrice["MSFT"] = "0";
			yourAsksPrice["SBUX"] = "0";
			yourAsksPrice["SNY"] = "0";
			yourAsksPrice["TSLA"] = "0";
			yourAsksPrice["TWTR"] = "0";
			
			yourAsksQuant["AAPL"] = "0";
			yourAsksQuant["ATVI"] = "0";
			yourAsksQuant["EA"] = "0";
			yourAsksQuant["FB"] = "0";
			yourAsksQuant["GOOG"] = "0";
			yourAsksQuant["MSFT"] = "0";
			yourAsksQuant["SBUX"] = "0";
			yourAsksQuant["SNY"] = "0";
			yourAsksQuant["TSLA"] = "0";
			yourAsksQuant["TWTR"] = "0";
		}
		
		private function setCurrentStock(str:String):void
		{
			selectedStock.text = str;
		}
		
		private function setCurrentBid(str:String):void
		{
			yourCurBid.text = str;
		}
		
		private function setCurrentAsk(str:String):void
		{
			yourCurAsk.text = str;
		}
		
		private function sendAskOrder(stock:String, price:String, quant:String):void
		{
			if (Main.inst.sm.getStockRowByName(stock).stockAmt > 0)
			{
				NetworkManager(Main.inst.manager).ask(stock, price, quant);
			}	
		}
		private function sendBidOrder(stock:String, price:String, quant:String):void
		{
			NetworkManager(Main.inst.manager).bid(stock, price, quant);
		}
		
		public function setTo(stock:String)
		{
			setCurrentStock(stock);
			setCurrentBid(yourBidsQuant[stock] + " at $" + yourBidsPrice[stock]); 
			setCurrentAsk(yourAsksQuant[stock] + " at $" + yourAsksPrice[stock]);
		}
		
		public function stocksBought(stock:String, quant:String):void
		{
			//update dictionary
			//update ask and sell order
		}
		
		public function stocksSold(stock:String, quant:String):void
		{
			//todo
		}
		
		public function setCurrentCash(stock:String)
		{
			TextField(Main.inst.getChildByName("cash_TXT")).text = stock;
		}
		
	}
	
}
