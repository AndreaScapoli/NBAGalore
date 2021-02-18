//
//  ViewController.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NetworkManager.shared.getTeams() { result in
            
            print(result)
        }
    }
}

extension TeamCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCellId", for: indexPath) as! TeamCollectionViewCell
        
        cell.configureCell(name: "pippo")
        
        return cell
    }
}

extension TeamCollectionViewController: UICollectionViewDelegate {
    
}


