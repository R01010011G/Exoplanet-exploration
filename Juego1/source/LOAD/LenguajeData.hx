package load;

typedef Lenguaje = {
	var iniciarTXT:String;
	var opcionesTXT:String;
    var controles:String;
    var gameover:String;
    var puntaje:String;
}

class LenguajeData {
	public static function dummy():Lenguaje
	{
		return {
			iniciarTXT: "",
			opcionesTXT: "",
			controles: "",
            gameover: "",
            puntaje: ""
		};
	}
}