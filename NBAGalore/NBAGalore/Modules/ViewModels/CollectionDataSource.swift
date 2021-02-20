//
//  TeamCollectionDataSource.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 19/02/21.
//

import UIKit

class CollectionDataSource<Cell: UICollectionViewCell,T>: NSObject, UICollectionViewDataSource {
    
    //MARK: Properties
    private var cellIdentifier : String!
    private var items : [T]!
    private var headerTitle: String
    var configureCell : (Cell, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], headerTitle: String, configureCell : @escaping (Cell, T) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.headerTitle = headerTitle
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionHeader", for: indexPath) as! TeamCollectionReusableView
            
            headerView.backgroundColor = .clear
            headerView.headerTitle.text = self.headerTitle
            
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
}
