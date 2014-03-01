package {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.text.TextField;
	
	public class Graph extends MovieClip {
		public var stockName:TextField;
		public var worthVector:Vector.<Number>;
		
		public var minVal:Number;
		public var maxVal:Number;
		
		public var myMask:Shape;
		public var myLines:Shape;
		
		public function Graph() {
			worthVector = new Vector.<Number>();
			minVal = 0;
			maxVal = 0;
			stop();
			
			myMask = new Shape();
			
			myMask.graphics.beginFill(0x000000);
			myMask.graphics.drawRect(0, -height, width, height);
			
			myLines = new Shape();
			
			stockName = TextField(getChildByName("stockName_TXT"));
			
			stockName.text = name.slice(6);
			addChild(myMask);
			addChild(myLines);
			myLines.mask = myMask;
		}
		
		public function update(newWorth:Number):void {
			worthVector.push(newWorth);
			if (worthVector.length > 12) {
				var removed:Number = worthVector.shift();
				if (minVal == removed || maxVal == removed) {
					for (var j:uint = 0; j < worthVector.length; j++) {
						var v:Number = worthVector[j];
						if (v > maxVal) {
							maxVal = v;
						} else if (v < minVal) {
							minVal = v;
						}
					}
				}
			}
			if (maxVal == 0 && minVal == 0) {
				maxVal = newWorth;
				minVal = newWorth;
			} else if (newWorth > maxVal) {
				maxVal = newWorth;
			} else if (newWorth < minVal) {
				minVal = newWorth;
			}
			myLines.graphics.clear();
			
			myLines.graphics.lineStyle(2, 0x990000, .75);
			var diff:Number = maxVal - minVal;
			for (var i:uint = 0; i < worthVector.length; i++) {
				var val:Number = worthVector[i];
				var s:Number = (val - minVal) / (diff);
				myLines.graphics.lineTo(i * 17, s * -116);
			}
			myLines.height = 116;
		
		}
	}

}
