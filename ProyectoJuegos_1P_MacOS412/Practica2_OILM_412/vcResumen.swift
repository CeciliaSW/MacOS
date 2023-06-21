//
//  vcResumen.swift
//  Practica2_OILM_412
//
//  Created by Adriana MV on 20/03/23.
//

import Cocoa

class vcResumen: NSViewController {
    var recibidoResultadoJuego: String?
    var recibidoContadorAciertos: Int?
    var recibidoContadorRachas: Int?
    var recibidoRachaMayor: Int?
    var recibidoContadorPreguntasHechas: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResumen.stringValue = "\(recibidoResultadoJuego!)\nResumen del juego: \nPuntos: \(recibidoContadorAciertos!)\nNúmero de rachas: \(recibidoContadorRachas!)\n Racha mayor: \(recibidoRachaMayor!)\nIntentos realizados: \(recibidoContadorPreguntasHechas!)"
    }
    
    @IBAction func cerrarPestaña(_ sender: NSButton) {
        self.view.window?.windowController?.close()
    }
    @IBOutlet weak var lblResumen: NSTextField!
}
