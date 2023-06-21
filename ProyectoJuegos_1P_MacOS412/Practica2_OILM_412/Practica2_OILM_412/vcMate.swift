//
//  vcMate.swift
//  Practica2_OILM_412
//
//  Created by MacOS on 22/03/23.
//

import Cocoa

class vcMate: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aplicarFormatoDiseño();
    }
    
    override var representedObject: Any? {
        didSet {
            
        }
    }
    
    var dificultad:String?
    
    var vidas = 3
    
    var contadorAciertos:Int = 0
    
    var arregloDeRachas: [Int] = []
    var númeroRachas: Int = 0
    var contadorRacha:Int = 0
    var rachaMayor:Int = 0
    
    var contadorIntentos:Int = 0;
    var criterioGanador:Int = 5
    
    let arregloImágenes:[String] = ["vidas"]
    var operador: String = ""
    var arregloOperadores:[String] = ["+","-","*"]
    var arregloNúmeros:[Int] = []
    var respuestaCorrectaCalculada = ""
    
    
    @IBOutlet weak var btnIniciar: NSButton!
    @IBOutlet weak var btnReiniciar: NSButton!
    
    @IBOutlet weak var etiquetaVidas: NSTextField!
    @IBOutlet weak var númeroVidas: NSTextField!
    @IBOutlet weak var vida1: NSImageView!
    @IBOutlet weak var vida2: NSImageView!
    @IBOutlet weak var vida3: NSImageView!
    
    @IBOutlet weak var etiquetaPregunta: NSTextField!
    @IBOutlet weak var etiquetaOperador: NSTextField!
    @IBOutlet weak var primerNúmero: NSTextField!
    @IBOutlet weak var segundoNúmero: NSTextField!
    
    @IBOutlet weak var respuestaEsperada: NSTextField!
    @IBOutlet weak var respuestaObtenida: NSTextField!
    @IBOutlet weak var entradaUsuario: NSTextField!
    
    @IBOutlet weak var btnVerificar: NSButton!
    @IBOutlet weak var sentenciaCorrectaOIncorrecta: NSTextField!
    @IBOutlet weak var etiquetaAciertos: NSTextField!
    @IBOutlet weak var indicadorNuméricoAciertos: NSTextField!
    @IBOutlet weak var impresiónGanadorOPerdedor: NSTextField!
    @IBOutlet weak var racha: NSTextField!
    
    func aplicarFormatoDiseño(){
        númeroVidas.isHidden=true
        establecerOperacionesAleatorias()
        desactivarControles()
        determinarImagenDeVida()
        vida1.isHidden=true
        vida2.isHidden=true
        vida3.isHidden=true
        
    }
    
    func ajustarNivel(){
    
        if(dificultad=="PRINCIPIANTE"){
            vidas = 3;
            criterioGanador = 5;
            vida1.isHidden=false
            vida2.isHidden=false
            vida3.isHidden=false
        }
        
        else if(dificultad=="INTERMEDIO"){
            vidas = 2;
            criterioGanador = 7;
            vida2.isHidden = false;
            vida1.isHidden = false;        }
        
        else if(dificultad=="AVANZADO"){
            vidas = 1;
            criterioGanador = 10;
            vida1.isHidden = false;
            
        }
    }
    
    func desactivarControles(){
        contadorAciertos=0
        indicadorNuméricoAciertos.stringValue=String(contadorAciertos)
        respuestaEsperada.isHidden=true
        racha.isHidden=true
        respuestaObtenida.isHidden=true
        sentenciaCorrectaOIncorrecta.isHidden=true
        entradaUsuario.isHidden=true
        btnIniciar.isHidden=false
        impresiónGanadorOPerdedor.isHidden=true
        btnReiniciar.isHidden=true
        btnVerificar.isHidden=true
        btnReiniciar.isHidden=true
        etiquetaVidas.isHidden=true
        indicadorNuméricoAciertos.isHidden=true
        etiquetaPregunta.isHidden = true;
        etiquetaAciertos.isHidden=true
        impresiónGanadorOPerdedor.stringValue="Ingrese su resultado:"
        etiquetaOperador.isHidden = true;
        primerNúmero.isHidden = true;
        segundoNúmero.isHidden = true;
        
    }
    
    func activarControles(){
        establecerOperacionesAleatorias();
        respuestaEsperada.isHidden=false
        respuestaObtenida.isHidden=false
        sentenciaCorrectaOIncorrecta.isHidden=false
        entradaUsuario.isHidden=false
        btnIniciar.isHidden=true
        impresiónGanadorOPerdedor.isHidden=false
        btnReiniciar.isHidden=false
        btnVerificar.isHidden=false
        btnReiniciar.isHidden=false
        númeroVidas.stringValue=String(vidas)
        etiquetaVidas.isHidden=false
        etiquetaPregunta.isHidden = false;
        indicadorNuméricoAciertos.isHidden=false
        etiquetaAciertos.isHidden=false
        racha.isHidden = false;
        etiquetaOperador.isHidden = false;
        primerNúmero.isHidden = false;
        segundoNúmero.isHidden = false;
        
        entradaUsuario.stringValue=""
        respuestaEsperada.stringValue=""
        respuestaObtenida.stringValue=""
    }

  
    @IBAction func iniciar(_ sender: Any) {
        ajustarNivel();
        activarControles();
    }
    
    @IBAction func reiniciar(_ sender: Any) {
        
        desactivarControles()
        criterioGanador=0
        contadorRacha=0
        racha.stringValue = "Racha:"
        + String(contadorRacha)
        arregloNúmeros.removeAll();
        operador = "";
        vida1.isHidden=true
        vida2.isHidden=true
        vida3.isHidden=true
    }
    
    func establecerOperacionesAleatorias(){
        operador = arregloOperadores.randomElement()!
        etiquetaOperador.stringValue = String(operador);
        
        while arregloNúmeros.count < 2 {
            let número = Int.random(in: 1...100)
            if !arregloNúmeros.contains(número)
            {
                arregloNúmeros.append(número)
            }
        }
            
        primerNúmero.stringValue = String(arregloNúmeros[0]);
        segundoNúmero.stringValue = String(arregloNúmeros[1]);
        
    }
    
    func calcularResultado(){
        var resultado : Int = 0;
        
        switch operador {
            case "+":
                resultado =  arregloNúmeros[0] + arregloNúmeros[1]
            case "-":
                resultado =   arregloNúmeros[0] - arregloNúmeros[1]
            case "*":
                resultado =  arregloNúmeros[0] * arregloNúmeros[1]
            default:
               print("Operador no válido.");
            }
        respuestaCorrectaCalculada = String(resultado);
        
        arregloNúmeros.removeAll();
        operador = "";
    }
    
    @IBAction func verificar(_ sender: Any) {
        
        calcularResultado();
        
        respuestaEsperada.stringValue = "Respuesta correcta: " + respuestaCorrectaCalculada
        
        let respuestaUsuario = entradaUsuario.stringValue
        respuestaObtenida.stringValue = "Tu respuesta: " +  respuestaUsuario
        
        if(respuestaUsuario == respuestaCorrectaCalculada)
        {
            registrarCorrecta()
            contadorIntentos += 1
            
        }
        else{
            registrarIncorrecta()
            contadorIntentos += 1
            
        }
        
        ganar()
    }
    
    func establecerGeneralidadesParaRespuesta()
    {
        establecerOperacionesAleatorias();
        entradaUsuario.stringValue=""
    }
    
    func registrarCorrecta ()
    {
        sentenciaCorrectaOIncorrecta.stringValue = "Correcto"
        contadorAciertos+=1
        contadorRacha+=1
        indicadorNuméricoAciertos.stringValue=String(contadorAciertos)
        establecerGeneralidadesParaRespuesta();
        
        racha.stringValue = "Racha: \(contadorRacha)"
    }
    
    func registrarIncorrecta()
    {
        sentenciaCorrectaOIncorrecta.stringValue = "Incorrecto"
        vidas = vidas-1
        númeroVidas.stringValue = "" + String(vidas)
        contadorRacha = 0
        establecerGeneralidadesParaRespuesta();
        determinarVidas();
        racha.stringValue = "Racha: \(contadorRacha)"
        arregloDeRachas.append(contadorRacha)
        
    }
    
    func deshabilitarSegúnFinalJuego() {
        btnVerificar.isHidden=true
        respuestaEsperada.isHidden=true
        respuestaObtenida.isHidden=true
        entradaUsuario.isHidden=true
        sentenciaCorrectaOIncorrecta.isHidden=true
        indicadorNuméricoAciertos.isHidden=true
        etiquetaAciertos.isHidden=true
        etiquetaVidas.isHidden=true
    }
    
    func determinarImagenDeVida(){
        vida1.image = NSImage(named: arregloImágenes[0])
        vida2.image = NSImage(named: arregloImágenes[0])
        vida3.image = NSImage(named: arregloImágenes[0])
    }
    
    func determinarVidas(){
        if(vidas==0){
            vida1.isHidden=true
            perder();
        }
        
        
        if(vidas==1){
            
            vida2.isHidden=true
        }
        
        if(vidas==2){
            
            vida3.isHidden=true
        }
    }
    
    func prepararNotificación(){
        deshabilitarSegúnFinalJuego();
        performSegue(withIdentifier: "resumenJuego", sender: self)
        
    }
    
    func perder(){
        impresiónGanadorOPerdedor.stringValue="Ya perdió, mi Inge."
        prepararNotificación();
    }
    
    func ganar(){
        if(contadorAciertos==criterioGanador ){
            impresiónGanadorOPerdedor.stringValue="Ya ganó, mi Inge."
            arregloDeRachas.append(contadorRacha)
            evaluarMayorRacha();
            prepararNotificación();
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
            if(segue.identifier == "resumenJuego"){
                let destinationVC = segue.destinationController as! vcResumen
                destinationVC.recibidoResultadoJuego = impresiónGanadorOPerdedor.stringValue
                destinationVC.recibidoContadorAciertos = contadorAciertos
                númeroRachas = arregloDeRachas.count;
                destinationVC.recibidoContadorRachas = númeroRachas
                destinationVC.recibidoRachaMayor = rachaMayor
                destinationVC.recibidoContadorPreguntasHechas = contadorIntentos
            }
    }
    }



