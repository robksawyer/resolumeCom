# resolumeCom Extended Version
> The changes made should make coding Flash interop simpler, more flexible, and (if handled properly) slightly faster. It also increases the legibility of your code.

## Main
Fully backwards-compatible (afaik - let me know if you run into any issues)
Minor behind-the-scenes performance enhancements
Availability of ExternalInterface is checked before callbacks are added (no more errors when debugging!)
Excessive commenting on Resolume class
Resolume class can enforce unique parameter names (i.e. will throw an error if two parameters with the same name are added) which leads to the biggie...
Parameter values can be called as properties from the Resolume class when enforcing unique names (i.e. if you have a parameter named 'bass' added to a Resolume instance called 'resolume', then resolume.bass will retrieve the current value of the parameter named 'bass')

## Additional Functions
Resolume.getParameterIndex: gets the index of a parameter specified by name when enforcing unique names
Resolume.getParameterNameAt: gets the name of a parameter specified by index
Resolume.getParameterType: gets the type code of a parameter specified by name when enforcing unique names
Resolume.getParameterTypeAt: gets the type code of a parameter specified by index
Resolume.addParameterListenerTo: adds a parameter listener to a parameter specified by name when enforcing unique names
Resolume.addParameterListenerAt: adds a parameter listener to a parameter specified by index

## Notes
Several functions have been changed to check variable types at run-time. It's unlikely that this will cause you any problems, but is something to be aware of. 

- All the Parameter subclasses' functions are now inherited from the Parameter class (thanks to run-time typing)
- The p_source property of the ChangeEvent class is now a Parameter, not an Object
