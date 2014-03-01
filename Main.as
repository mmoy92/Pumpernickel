package {
	import flash.display.Sprite;
	import flash.events.*;

	
	public class Main extends Sprite 
	{
		private var fps:FPSMonitor;
		public var auto:AutoBot;
		public var manager:NetworkManager;
		public var dt:DetailTab;
		public var sm:StockRowManager;
		
		public var gm:GraphManager;
		
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
			gm = new GraphManager();
			fps = new FPSMonitor();
			auto = new AutoBot();
			
			fps.y = 60;
			//addChild(fps);
		}

	}
}

