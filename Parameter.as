package resolumeCom {
	public class Parameter {

		internal var name:String;
		internal var type:Number = -1;
		internal var currentValue:*;
		internal var defaultValue:*;
		
		//value controls
		public function setValue(value_:*, forceChange:Boolean = false):void {
			if (!forceChange && value_==this.currentValue)
				return;
			this.currentValue = value_;
		}
		public function getValue():* {
			return this.currentValue;
		}
		public function getDefault():* {
			return this.defaultValue;
		}
		
		//callback to Resolume
		public function getXmlRep():String {
			if(this.type==-1) { return ""; }
			
			return "<param type='" + this.type + "' name='" + this.name + "' value='" + this.currentValue + "'/>";
		}
	}
}