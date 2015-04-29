package resolumeCom {	
	public class EventParameter extends Parameter
	{
		//constructor
		public function EventParameter(name_:String) {
			this.name = name_;
			this.type = 1;
			this.defaultValue = false;
			this.currentValue = false;
		}
	}
}