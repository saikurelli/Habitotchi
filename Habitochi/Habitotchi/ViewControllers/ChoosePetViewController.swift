//
//  ChoosePetViewController.swift
//  Habitotchi
//
//  Created by Peter on 3/6/23.
//

import UIKit

class ChoosePetViewController: UIViewController {
    
    let animals = ["cat0", "cat1", "cat2", "dog0", "dog1", "dog2"]
    
    @IBOutlet weak var animalCollectionView: UICollectionView!
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalCollectionView.delegate = self
        animalCollectionView.dataSource = self
        
    }
}

extension ChoosePetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = animalCollectionView.dequeueReusableCell(withReuseIdentifier: "animalCell", for: indexPath) as! AnimalCell
            
        cell.animalImageView.image = UIImage(named: animals[indexPath.row])
        cell.imageFileName = animals[indexPath.row]
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let otherVC = delegate as! AnimalChanger
        let selectedImage = collectionView.cellForItem(at: indexPath) as! AnimalCell
        otherVC.changeAnimal(newAnimal: selectedImage.animalImageView.image!, newAnimalFileName: selectedImage.imageFileName)
        self.dismiss(animated: true)
    }

}

