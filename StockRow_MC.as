package {
	
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
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
		
		public var grade:int;
		
		public function StockRow_MC() {
			stock = name.slice(6);
			
			grade = 0;
			
			stockAmtTxt = TextField(getChildByName("stockAmt_TXT"));
			stockNameTxt = TextField(getChildByName("stockName_TXT"));
			netWorthTxt = TextField(getChildByName("networth_TXT"));
			dividendTxt = TextField(getChildByName("dividend_TXT"));
			
			bar = MovieClip(getChildByName("bar_MC"));
			
			askAmtTxt = TextField(getChildByName("ask_TXT"));
			bidAmtTxt = TextField(getChildByName("buy_TXT"));
			
			stockNameTxt.text = stock;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			Main.inst.dt.setTo(stock);
		}
		
		public function updateWorth(i:Number):void {
			if (i > StockRowManager.inst.maxWorth) {
				StockRowManager.inst.maxWorth = i + 5;
			}
			var str:String = i.toString();
			netWorthTxt.text = str.slice(0, str.indexOf(".") + 5);
			
			if (i > netWorth) {
				grade++;
			} else if (i < netWorth) {
				grade--;
			}
			grade = grade < -20 ? -20 : grade > 20 ? 20 : grade;
			
			netWorth = i;
		}
		
		public function updateDividend(i:Number):void {
			dividendTxt.text = i.toString();
		
		}
		
		public function updateStockAmount(i:int) {
			stockAmtTxt.text = i.toString();
		}
		
		public function updateAskBid(ask:Number, bid:Number):void {
			var askStr:String = ask.toString();
			askAmtTxt.text = askStr.slice(0, askStr.indexOf(".") + 3);
			
			var bidStr:String = bid.toString();
			bidAmtTxt.text = bidStr.slice(0, bidStr.indexOf(".") + 3);
		}
		
		public function updateBar():void {
			var newScale:Number = netWorth / StockRowManager.inst.maxWorth;
			var clr:int;
			var amt:Number = grade/20;
			
			if (grade < - 5) {
				clr = 0xFF0000;
			} else if (grade > 5) {
				clr = 0x33cc66;
				
			} else {
				clr = 0x7D866C;
				amt = 1;
			}
			amt = Math.abs(amt);
			TweenMax.to(bar, 0.5, {scaleX: newScale, ease: Strong.easeOut, colorTransform:{tint:clr, tintAmount:amt}});
			
			//if (bar.scaleX > 0.7) {
			//dividendTxt.x = bar.x + bar.width - dividendTxt.textWidth * 2;
			//} else {
			//dividendTxt.x = bar.x + bar.width;
			//}
		}
	}

}
