package {
	import flash.display.Sprite;
	import flash.events.*;

	
	public class Main extends Sprite 
	{
		private var manager:NetworkManager;
		private var dt:DetailTab;
		private var sm:StockRowManager;
		
		public static var inst:Main;
		
		public function Main() {
	
			inst = this;
			manager = new NetworkManager();
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}

		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			dt = DetailTab(this.getChildByName("detailTab_MC"));
			sm = new StockRowManager();
		}

	}
}

