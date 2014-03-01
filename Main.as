package {
	import flash.display.Sprite;
	import flash.events.*;

	
	public class Main extends Sprite {
		private var manager:NetworkManager;

		
		public function Main() {
	
			manager = new NetworkManager();
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		
		}

		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
		}

	}
}

