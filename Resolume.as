package resolumeCom
{
	import resolumeCom.*;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.external.ExternalInterface;

	//main class
	dynamic final public class Resolume extends Proxy {
		private var _publishedParameters:Vector.<Parameter>; //parameter container
		
		//constructor
		public function Resolume() {
			//instantiates parameter container and the external interface (if available)
			this._publishedParameters = new Vector.<Parameter>();
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("getResolumeApiInfo", getResolumeApiInfo);
				ExternalInterface.addCallback("getParametersInfo", getParametersInfo);
				ExternalInterface.addCallback("setFloatParameter", setFloatParameter);
				ExternalInterface.addCallback("setBooleanParameter", setBooleanParameter);			
				ExternalInterface.addCallback("setEventParameter", setEventParameter);						
				ExternalInterface.addCallback("setStringParameter", setStringParameter);
			}
		}
		
		//internal-only
		private function checkNameExists(name:String):Boolean {
			//checks if there is a parameter with the given name
			for(var i:int=0; i<this._publishedParameters.length; ++i) {
				if(this._publishedParameters[i].name==name) {
						return true;
				}
			}
			return false;
		}
		
		//add parameters
		public function addFloatParameter(name:String, defaultValue:Number):FloatParameter {
			//adds a float parameter to the next available spot in the parameter container
			if(this.checkNameExists(name)) { throw new Error("The name '" + name + "' is already in use by another parameter"); }
			
			var parameter:FloatParameter = new FloatParameter(name, defaultValue);
			this._publishedParameters[this._publishedParameters.length] = parameter;
			return parameter;
		}
		public function addBooleanParameter(name:String, defaultValue:Boolean):BooleanParameter {
			//adds a boolean parameter to the next available spot in the parameter container
			if(this.checkNameExists(name)) { throw new Error("The name '" + name + "' is already in use by another parameter"); }
			
			var parameter:BooleanParameter = new BooleanParameter(name, defaultValue);
			this._publishedParameters[this._publishedParameters.length] = parameter;
			return parameter;
		}
		public function addEventParameter(name:String):EventParameter {
			//adds an event parameter to the next available spot in the parameter container
			if(this.checkNameExists(name)) { throw new Error("The name '" + name + "' is already in use by another parameter"); }
			
			var parameter:EventParameter = new EventParameter(name); 
			this._publishedParameters[this._publishedParameters.length] = parameter;
			return parameter;
		}		
		public function addStringParameter(name:String, defaultValue:String):StringParameter {
			//adds a string parameter to the next available spot in the parameter container
			if(this.checkNameExists(name)) { throw new Error("The name '" + name + "' is already in use by another parameter"); }
			
			var parameter:StringParameter = new StringParameter(name, defaultValue); 
			this._publishedParameters[this._publishedParameters.length] = parameter;
			return parameter;
		}
		
		//setter callbacks
		public function setFloatParameter(index:Number, value:Number):Number {
			//sets a float parameter at the given index
			if (index >=0 && index < this._publishedParameters.length) {
				if (this._publishedParameters[index].type!=10) { return -1; }
				
				this._publishedParameters[index].setValue(value, true);
				return Number(this._publishedParameters[index].currentValue);		
			}
			return -1;
		}
		public function setBooleanParameter(index:Number, value:Number):Number {
			//sets a boolean parameter at the given index
			if (index >=0 && index < this._publishedParameters.length) {
				if (this._publishedParameters[index].type!=0) { return 0; }
				
				this._publishedParameters[index].setValue(value, true)
				return Number(this._publishedParameters[index].currentValue);		
			}
			return 0;
		}
		public function setEventParameter(index:Number, value:Number):Number {
			//sets an event parameter at the given index
			if (index >=0 && index < this._publishedParameters.length) {
				if (this._publishedParameters[index].type!=1) { return 0; }
				
				this._publishedParameters[index].setValue(value)
				return Number(this._publishedParameters[index].currentValue);		
			}
			return 0;
		}
		public function setStringParameter(index:Number, value:String):String {
			//sets a string parameter at the given index
			if (index >=0 && index < this._publishedParameters.length) {
				if (this._publishedParameters[index].type!=100) { return ""; }
				
				this._publishedParameters[index].setValue(value, true);
				return String(this._publishedParameters[index].currentValue);		
			}
			return "";
		}
		
		//utility functions
		public function getNumParameters(): Number {
			//returns the number of parameters in the parameter container
			return this._publishedParameters.length;
		}
		
		//info callbacks
		public function getResolumeApiInfo():String {
			//gets version info xml
			var xmlVersion:String = "<version major='1' minor='0' micro='0' as='3'/>";
			return xmlVersion;
		}
		public function getParametersInfo():String {
			//create a new array of parameter representations
			//Flash automagically serializes it to xml when received in the host
			//I love that the last line says 'automagically'; please don't change it - <3 Nate
			var xmlRep:String = "<params>";
			for(var i:Number=0; i<this._publishedParameters.length; ++i) {
				xmlRep += this._publishedParameters[i].getXmlRep();
			}
			xmlRep += "</params>";
			return xmlRep;
		}
		
		//new getter
		flash_proxy override function getProperty(name:*):* {
			//override get method using proxy class
			for(var i:int=0; i<this._publishedParameters.length; ++i) {
				if(this._publishedParameters[i].name==name.localName) { return this._publishedParameters[i].currentValue; }
			}
			throw new Error('Access of possibly undefined property ' + name.localName, 1119);
		}
	}
}

