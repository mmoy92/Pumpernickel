package {
	import flash.display.Sprite;
	import flash.net.Socket;
	import flash.events.*;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetworkManager {
		private var socket:Socket;
		private var myTimer:Timer;
		private var names:Array = new Array("AAPL", "ATVI", "EA", "FB", "GOOG", "MSFT", "SBUX", "SNY", "TSLA", "TWTR");
		
		public function NetworkManager() {
			myTimer = new Timer(1000);
			myTimer.addEventListener(TimerEvent.TIMER, sendRequest);
			myTimer.start();
			
			socket = new Socket();
			
			Security.allowDomain("*");
			
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onResponse);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			
			socket.connect("172.31.231.85", 17429);
		
		}
		
		function onConnect(e:Event):void {
			socket.writeUTFBytes("teambread lettuce\nMY_CASH");
			socket.writeUTFBytes("\n");
			trace("connect");
		
		}
		
		private function sendRequest(e:Event):void {
			socket.writeUTFBytes("MY_CASH");
			socket.writeUTFBytes("\n");
			socket.flush()
			
			socket.writeUTFBytes("SECURITIES");
			socket.writeUTFBytes("\n");
			socket.flush();
			
			for (var i:int = 0; i < 10; i++) {
				socket.writeUTFBytes("OFFERS " + names[i]);
				socket.writeUTFBytes("\n");
				socket.flush();
			}
			
			socket.writeUTFBytes("MY_SECURITIES");
			socket.writeUTFBytes("\n");
			socket.flush()
		
		}
		
		public function sendCommand(text:String):void {
			Main.inst.stage.frameRate = 1;
			socket.writeUTFBytes(text);
			socket.writeUTFBytes("\n");
			socket.flush();
			Main.inst.stage.frameRate = 60;
		}
		
		function onClose(e:Event):void {
			// Security error is thrown if this line is excluded
			socket.close();
			trace("close")
		}
		
		function onError(e:IOErrorEvent):void {
			trace("IO Error: " + e);
		}
		
		function onSecError(e:SecurityErrorEvent):void {
			trace("Security Error: " + e);
		}
		
		function onResponse(e:ProgressEvent):void {
			if (socket.bytesAvailable > 0) {
				var str:String = socket.readUTFBytes(socket.bytesAvailable);
				parse(str);
			}
		}
		
		function parse(str:String):void {
			var par:Array = str.split(" ");
			var askIndex:int = 5;
			var index:int = 1;
			
			if (par[0] == "SECURITIES_OUT") {
				Main.inst.sm.maxWorth = 0;
				for (var i:int = 0; i < 10; i++) {
					if(index < par.length){
						Main.inst.sm.getStockRowByName(par[index]).updateWorth(Number(par[index + 1]));
						Main.inst.sm.getStockRowByName(par[index]).updateDividend(Number(par[index + 2]));
						//Main.inst.sm.getStockRowByName(par[index]).updateVolatility(Number(par[index+3]));
						
						index += 4;
					}
				}
				Main.inst.sm.updateBars();
				
				//trace("");
				
			} else if (par[0] == "SECURITY_OFFERS_OUT") {
				while (par[askIndex] != "ASK") {
					askIndex++;
				}
				Main.inst.sm.getStockRowByName(par[2]).updateAskBid(Number(par[askIndex + 2]), Number(par[3]));
				//trace("");
			}
			
			else if (par[0] == "MY_SECURITIES_OUT") {
				for (var own:int = 0; own < 10; own++) {
					Main.inst.sm.getStockRowByName(par[index]).updateMySecurities(Number(par[index + 1]));
					index += 3;
				}
				//trace("");
			}
			
			else if (par[0] == "MY_CASH_OUT") {
				Main.inst.dt.cash = par[1];
				DetailTab(Main.inst.dt).setCurrentCash(par[1]);
				trace("");
			}
			Main.inst.sm.updateDisplay();
		
		}
		
		function bid(name:String, price:String, amt:String) {
			Main.inst.stage.frameRate = 1;
			socket.writeUTFBytes("BID " + name + " " + price + " " + amt);
			socket.writeUTFBytes("\n");
			socket.flush();
			Main.inst.stage.frameRate = 60;
		}
		
		function ask(name:String, price:String, amt:String) {
			Main.inst.stage.frameRate = 1;
			socket.writeUTFBytes("ASK " + name + " " + price + " " + amt);
			socket.writeUTFBytes("\n");
			socket.flush();
			Main.inst.stage.frameRate = 60;
		}
		
		function clearBid(name:String) {
			socket.writeUTFBytes("CLEAR_BID " + name);
			socket.writeUTFBytes("\n");
			socket.flush();
		}
		
		function clearAsk(name:String) {
			socket.writeUTFBytes("CLEAR_ASK " + name);
			socket.writeUTFBytes("\n");
			socket.flush();
		}
	}

}