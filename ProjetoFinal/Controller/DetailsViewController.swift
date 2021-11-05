//
//  DetailsViewController.swift
//  ProjetoFinal
//
//  Created by Elisa Kalil on 26/10/21.

import UIKit
import Kingfisher
import CoreData

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    var selectedPokemon: Pokemon?
    
    // MARK: Outlets
    @IBOutlet weak var viewBlueBackground: UIView!
    @IBOutlet weak var viewYellowBackground: UIView!
    @IBOutlet weak var buttonFavoritar: UIButton!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelPeso: UILabel!
    @IBOutlet weak var labelAltura: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Actions
    @IBAction func buttonFavoritar(_ sender: UIButton) {
        
//        let context = DataBaseController.persistentContainer.viewContext
//        let fav = Favoritos(context: context)
//        do {
//            guard let name = fav.pokename else { return }
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoritos")
//            fetchRequest.predicate =  NSPredicate(format: "pokename =%@", name)
//            let fetchedPokemons = try context.fetch(fetchRequest)
//            print(fetchedPokemons.count)
//
//            if fetchedPokemons.count == 0 {
//
//                fav.pokename = selectedPokemon?.name?.capitalized
//                fav.pokeimage = selectedPokemon?.sprites?.front_default
//                fav.pokealtura = Float(selectedPokemon?.height ?? 0)
//                fav.pokepeso = Float(selectedPokemon?.weight ?? 0)
//                DataBaseController.saveContext()
//                let viewController = FavoriteViewController()
//                navigationController?.pushViewController(viewController, animated: true)
//
//            } else {
//                self.displayAlert(message: "O elefante \(String(describing: selectedPokemon?.name?.capitalized)) já está favoritado")
//            }
//        } catch let error {
//            print(error)
//        }
        
        let context = DataBaseController.persistentContainer.viewContext
        let fav = Favoritos(context: context)
        fav.pokename = selectedPokemon?.name?.capitalized
        fav.pokeimage = selectedPokemon?.sprites?.front_default
        fav.pokealtura = Float(selectedPokemon?.height ?? 0)
        fav.pokepeso = Float(selectedPokemon?.weight ?? 0)
        DataBaseController.saveContext()
        let viewController = FavoriteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Methods
//    private func displayAlert(message: String) {
//        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
//        let buttonOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//        alert.addAction(buttonOk)
//        DispatchQueue.main.async {
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
    private func setupUI() {
        guard let weight = selectedPokemon?.weight else { return }
        guard let height = selectedPokemon?.height else { return }
        self.title = selectedPokemon?.name?.capitalized
        self.labelNome.text = selectedPokemon?.name?.capitalized
        self.labelPeso.text = "\(weight) g"
        self.labelAltura.text = "\(height) cm"
        if let imageURL = selectedPokemon?.sprites?.front_default {
            if let url = URL(string: imageURL) {
                imagePokemon.kf.setImage(with: url,
                                         options: [.cacheOriginalImage],
                                         completionHandler: { result in })
            }
        }
        viewBlueBackground.layer.cornerRadius = 100
    }
    
}
