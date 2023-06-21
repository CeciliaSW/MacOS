//
//  vcMainPage.swift
//  Practica2_OILM_412
//
//  Created by ISSC_412_2023 on 15/03/23.
//

import Cocoa

class vcNivelesPreguntados: NSViewController {
    var posicionImagenesVidas = 0
    var aciertosAGanar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func regresarASeleccionJuego(_ sender: NSButton) {
        self.view.window?.windowController?.close()
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
        switch(segue.identifier){
        case "principiante":
            posicionImagenesVidas = 0
            aciertosAGanar = 5
            let destinationVC = segue.destinationController as! vcPreguntados
            destinationVC.receivePosicionImagenesVidas = posicionImagenesVidas
            destinationVC.receiveAciertosAGanar = aciertosAGanar
            break
        case "intermedio":
            posicionImagenesVidas = 4
            aciertosAGanar = 7
            let destinationVC = segue.destinationController as! vcPreguntados
            destinationVC.receivePosicionImagenesVidas = posicionImagenesVidas
            destinationVC.receiveAciertosAGanar = aciertosAGanar
            break
        case "avanzado":
            posicionImagenesVidas = 7
            aciertosAGanar = 10
            let destinationVC = segue.destinationController as! vcPreguntados
            destinationVC.receivePosicionImagenesVidas = posicionImagenesVidas
            destinationVC.receiveAciertosAGanar = aciertosAGanar
            break
        default:
            break
        }
    }
    
}
