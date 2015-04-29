package resolumeCom {
	public class FloatParameter extends Parameter
	{
		//constructor
		public function FloatParameter(name_:String, defaultValue_:Number) {
			this.name = name_;
			this.type = 10;
			this.defaultValue = defaultValue_;
			this.currentValue = defaultValue_;
		}
	}
}