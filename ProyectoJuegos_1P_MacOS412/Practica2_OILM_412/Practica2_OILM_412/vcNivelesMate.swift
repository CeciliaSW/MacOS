//
//  vcNivelesMate.swift
//  Practica2_OILM_412
//
//  Created by MacOS on 22/03/23.
//

import Cocoa

class vcNivelesMate: NSViewController {

    var dificultad = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func seleccionarDificultad(_ sender: NSButton){
               dificultad = String(sender.title)
               performSegue(withIdentifier: "irDificultad", sender: self)
        }
        
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDificultad" {
            let destinationVC = segue.destinationController as! vcMate
        
            destinationVC.dificultad = dificultad;
        }
      
    }
    
    @IBAction func regresarASelecciónJuego(_ sender: NSButton) {
        self.view.window?.windowController?.close()
    }
}
