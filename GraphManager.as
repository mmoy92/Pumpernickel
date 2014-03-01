package {
	
	/**
	 * ...
	 * @author Michael Moy
	 */
	public class GraphManager {
		private var allGraphs:Vector.<Graph>;
		public var AAPL:Graph;
		public var ATVI:Graph;
		public var EA:Graph;
		public var FB:Graph;
		public var GOOG:Graph;
		public var MSFT:Graph;
		public var SBUX:Graph;
		public var SNY:Graph;
		public var TSLA:Graph;
		public var TWTR:Graph;
		
		public function GraphManager() {
			allGraphs = new Vector.<Graph>();
			
			AAPL = Graph(Main.inst.getChildByName("graph_AAPL"));
			ATVI = Graph(Main.inst.getChildByName("graph_ATVI"));
			EA = Graph(Main.inst.getChildByName("graph_EA"));
			FB = Graph(Main.inst.getChildByName("graph_FB"));
			GOOG = Graph(Main.inst.getChildByName("graph_GOOG"));
			MSFT = Graph(Main.inst.getChildByName("graph_MSFT"));
			SBUX = Graph(Main.inst.getChildByName("graph_SBUX"));
			SNY = Graph(Main.inst.getChildByName("graph_SNY"));
			TSLA = Graph(Main.inst.getChildByName("graph_TSLA"));
			TWTR = Graph(Main.inst.getChildByName("graph_TWTR"));
			
			allGraphs.push(AAPL, ATVI, EA, FB, GOOG, MSFT, SBUX, SNY, TSLA, TWTR);
		}
		public function getGraphByName(str:String):Graph {
			if (str == "AAPL") {
				return AAPL;
			} else if (str == "ATVI") {
				return ATVI;
			} else if (str == "EA") {
				return EA;
			} else if (str == "FB") {
				return FB;
			} else if (str == "GOOG") {
				return GOOG;
			} else if (str == "MSFT") {
				return MSFT;
			} else if (str == "SBUX") {
				return SBUX;
			} else if (str == "SNY") {
				return SNY;
			} else if (str == "TSLA") {
				return TSLA;
			} else if (str == "TWTR") {
				return TWTR;
			} else {
				return null;
			}
		}
	}

}