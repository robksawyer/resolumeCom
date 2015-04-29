package resolumeCom {
	public class StringParameter extends Parameter
	{
		//constructor
		public function StringParameter(name_:String, defaultValue_:String) {
			this.name = name_;
			this.type = 100;
			this.defaultValue = defaultValue_;
			this.currentValue = defaultValue_;
		}
	}
}