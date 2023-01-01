//
//  AnotacoesViewController.swift
//  NotasDiarias
//
//  Created by Luis Lima on 31/12/22.
//

import UIKit
import CoreData

class AnotacoesViewController: UIViewController {
    
    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configurações Iniciais
        self.texto.becomeFirstResponder()
        
        if anotacao != nil{
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
        }else{
            self.texto.text = ""
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil {
            self.atualizarAnotacao()
        } else {
            self.salvarAnotacao()
        }
        
        //voltar Tela Principal
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao() {
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        //salvar dados
        do {
            try context.save()
            print("Sucesso ao Atualizar Anotação")
        } catch let erro{
            print("Erro ao Atualizar Anotação" + erro.localizedDescription)
        }
    }
    
    func salvarAnotacao() {
        //cria objeto para Anotacao
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        //configura anotacao
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        //salvar dados
        do {
            try context.save()
            print("Sucesso ao Salvar Anotação")
        } catch let erro{
            print("Erro ao Salvar Anotação" + erro.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
