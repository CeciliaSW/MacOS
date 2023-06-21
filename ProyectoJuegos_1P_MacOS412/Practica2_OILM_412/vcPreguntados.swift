//
//  ViewController.swift
//  Practica2_OILM_412
//
//  
//

import Cocoa

class vcPreguntados: NSViewController {
    
    var contadorVidas = 0;
    var imagenesVidasArreglo: [String] = ["3vidasllenas","3vidas1perdida","3vidas2perdidas","3vidasvacias","2vidasllenas","2vidas1perdida","2vidasvacias","1vida","vidavacia"];
    
    var contadorPreguntas = 0;
    var arregloPreguntas: [String] = ["The Beatles es el grupo que más discos ha vendido en la historia.","Machu Picchu está en Perú.","China es el pais más grande.","El Nilo es el río más grande del mundo.","La casa de Ana Frank está en Berlín.","El bíceps es el músculo más fuerte del cuerpo.","Los delfines son mamíferos.","En el teclado a lado de la letra ñ, se encuentra la letra k.","El nitrógeno es el elemento más abundante en la atmósfera.","El francés es el idioma oficial de Andorra.","Las espinacas son el alimento con más hierro.","En Cuba no existe la Coca-Cola.","Los caracoles pueden dormir un mes.","No se puede estornudar con los ojos abiertos.","Cleopatra era de ascendencia egipcia.","Google iba a llamarse BackRub.","Las fresas tienen más vitamina c que las naranjas.","El monte Fuji es la montaña más alta de Japón.","Los hipopótamos sudan una sustancia roja.","En una baraja de cartas, el rey tiene bigote.","En Buscando a Nemo, el protagonista es un pez globo.","Hay 14 huesos en el pie.","Los peces de colores tienen una memoria de dos segundos.","Los cinco anillos de la bandera olímpica están entrelazados.","Los plátanos son curvos porque crecen hacia el sol.","Venus es el planeta más caliente del sistema solar.","Thomas Edison descubrió la gravedad.","Un pulpo tiene 3 corazones.","El café está hecho de bayas.","El hueso radio está en la pierna."];
    
    var receivePosicionImagenesVidas: Int?
    var arregloImagenesPreguntas: [String] = ["beatles","machupicchu","china","rionilo","anafrank","biceps","delfin","letran","nitrogeno","andorra","espinacas","cubacoca","caracol","estornudo","cleopatra","google","fresas","fuji","hipopotamo","baraja","nemo","huesospies","peces","olimpicos","platano","venus","edison","pulpo","cafe","huesospierna"];
    
    var arregloRespuestas: [String] = ["Verdadero","Verdadero","Falso","Verdadero","Falso","Falso","Verdadero","Falso","Verdadero","Falso","Falso","Verdadero","Falso","Verdadero","Falso","Verdadero","Verdadero","Verdadero","Verdadero","Verdadero","Falso","Falso","Falso","Verdadero","Verdadero","Verdadero","Falso","Verdadero","Verdadero","Falso"];
 
    
    var contadorAciertos = 0;
    var receiveAciertosAGanar: Int?
    var aciertosAGanar = 0;
    
    var contadorRacha = 0;
    var arregloDeRachas: [Int] = []
    var númeroRachas : Int = 0;
    var rachaMayor = 0;
    
    var contadorPreguntasHechas = 0;
    var resultadoJuego = ""
    
    var numeroRandomSecuencia: [Int] = []
    
    @IBOutlet weak var imgVidas: NSImageView!
    
    @IBOutlet weak var btnIniciarReiniciar: NSButton!
    
    @IBOutlet weak var imgPreguntas: NSImageView!
    @IBOutlet weak var lblPreguntas: NSTextField!
    
    @IBOutlet weak var btnVerdadero: NSButton!
    @IBOutlet weak var btnFalso: NSButton!
    @IBOutlet weak var lblAciertos: NSTextField!
    @IBOutlet weak var lblRacha: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cambiarEntreModos(receivePosicionImagenesVidas!, receiveAciertosAGanar!)
        encenderApagarControladores(false)
        mostrarBotonesRespuestas(false)
        btnIniciarReiniciar.isHidden = true
        generarNumeroRandom()
        preguntaARealizar()
    }

    override var representedObject: Any? {
        didSet {
    
        }
    }
    
    func cambiarEntreModos(_ posicionImagenVidas: Int, _ numeroAciertosAGanar: Int){
        imgVidas.image = NSImage(named: imagenesVidasArreglo[posicionImagenVidas])
        aciertosAGanar = numeroAciertosAGanar;
        contadorVidas = posicionImagenVidas;
    }
    
    func encenderApagarControladores(_ encenderApagar: Bool){
        lblAciertos.isHidden = encenderApagar;
        imgVidas.isHidden = encenderApagar;
        imgPreguntas.isHidden = encenderApagar;
        lblPreguntas.isHidden = encenderApagar;
        lblRacha.isHidden = encenderApagar
    }
    
    func mostrarBotonesRespuestas(_ mostrar:Bool){
        btnVerdadero.isHidden = mostrar;
        btnFalso.isHidden = mostrar;
    }
    
    @IBAction func reiniciarJuego(_ sender: NSButton) {
        self.view.window?.windowController?.close()
    }
    
    func generarNumeroRandom(){
        let secuencia = 0...29
        numeroRandomSecuencia = secuencia.shuffled()
    }
    
    func preguntaARealizar(){
        lblPreguntas.stringValue = arregloPreguntas[numeroRandomSecuencia[contadorPreguntas]]
        imgPreguntas.image = NSImage(named: arregloImagenesPreguntas[numeroRandomSecuencia[contadorPreguntas]])
    }
    
    @IBAction func responderPreguntas(_ sender: NSButton){
        if(sender.title != arregloRespuestas[numeroRandomSecuencia[contadorPreguntas]]){
            contadorVidas += 1;
            imgVidas.image = NSImage(named: imagenesVidasArreglo[contadorVidas])
            arregloDeRachas.append(contadorRacha)
            contadorRacha = 0
            lblRacha.stringValue = "Racha: \(contadorRacha)"
            contadorPreguntasHechas += 1
        }else{
            contadorAciertos += 1
            contadorRacha += 1
            lblAciertos.stringValue = "Puntos: \(contadorAciertos)"
            lblRacha.stringValue = "Racha: \(contadorRacha)"
            contadorPreguntasHechas += 1
        }
        contadorPreguntas += 1
        preguntaARealizar()
        ganar()
        perder()
    }
    
    func mostrarMensajeGanarPerder(_ mensaje:String){
        resultadoJuego = mensaje
        btnIniciarReiniciar.isHidden = false
    }
    
    func perder(){
        if(contadorVidas == 3 || contadorVidas == 6 || contadorVidas == 8){
            mostrarMensajeGanarPerder("Has perdido,\nya no te quedan más vidas.")
            encenderApagarControladores(true)
            lblPreguntas.stringValue = ""
            mostrarBotonesRespuestas(true)
            arregloDeRachas.append(contadorRacha)
            evaluarMayorRacha()
            performSegue(withIdentifier: "irAResumen", sender: self)
        }
        
    }
    
    func ganar(){
        if(contadorAciertos == aciertosAGanar){
            mostrarMensajeGanarPerder("Felicidades. ¡¡¡Has ganado!!!")
            encenderApagarControladores(true)
            lblPreguntas.stringValue = ""
            mostrarBotonesRespuestas(true)
            arregloDeRachas.append(contadorRacha)
            evaluarMayorRacha()
            performSegue(withIdentifier: "irAResumen", sender: self)
        }
        
    }
    
    func evaluarMayorRacha(){
        for i in 0...arregloDeRachas.count-1{
            if(arregloDeRachas[i] > rachaMayor){
                rachaMayor = arregloDeRachas[i]
            }
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
        evaluarMayorRacha()
        if(segue.identifier == "irAResumen"){
            let destinationVC = segue.destinationController as! vcResumen
            destinationVC.recibidoResultadoJuego = resultadoJuego
            destinationVC.recibidoContadorAciertos = contadorAciertos
            destinationVC.recibidoRachaMayor = rachaMayor
            númeroRachas = arregloDeRachas.count;
            destinationVC.recibidoContadorRachas = númeroRachas
            destinationVC.recibidoContadorPreguntasHechas = contadorPreguntasHechas
        }
    }
}

