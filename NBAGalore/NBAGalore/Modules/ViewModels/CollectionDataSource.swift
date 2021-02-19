//
//  TeamCollectionDataSource.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 19/02/21.
//

import Foundation
import UIKit

class CollectionDataSource<Cell: UICollectionViewCell,T>: NSObject, UICollectionViewDataSource {
    
    //MARK: Properties
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (Cell, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (Cell, T) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        
        return cell
    }
    
    
    
}
