package resolumeCom {
	public class BooleanParameter extends Parameter
	{
		//constructor
		public function BooleanParameter(name_:String, defaultValue_:Boolean) {
			this.name = name_;
			this.type = 0;
			this.defaultValue = defaultValue_;
			this.currentValue = defaultValue_;
		}
	}
}