package {
	import flash.display.Sprite;
	import flash.net.Socket;
	import flash.events.*;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Main extends Sprite {
		//private var socket:CustomSocket;
		private var socket:Socket;
		private var outputTxt:TextField;
		private var inputTxt:TextField;
		private var myTimer:Timer;
		
		public function Main() {
			//socket = new CustomSocket("172.31.231.85", 17429);
			
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
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.ENTER) {
				sendCommand(inputTxt.text);
			}
		}
		
		private function sendCommand(text:String):void {
			trace(text);
			socket.writeUTFBytes(text);
			socket.writeUTFBytes("\n");
			socket.flush();
		}
		
		private function sendRequest(e:Event):void {
			socket.writeUTFBytes("SECURITIES");
			socket.writeUTFBytes("\n");
			socket.flush();
			trace("go");
		}
		
		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			outputTxt = TextField(getChildByName("output_TXT"));
			inputTxt = TextField(getChildByName("input_TXT"));
		}
		
		function onConnect(e:Event):void {
			socket.writeUTFBytes("teambread lettuce\nSECURITIES");
			socket.writeUTFBytes("\n");
			trace("connect");
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
				outputTxt.text = str;
				trace("response");
			}
		}
	}
}

