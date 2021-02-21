//
//  TeamCollectionDataSource.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 19/02/21.
//

import UIKit

class CollectionDataSource<Cell: UICollectionViewCell, Header: UICollectionReusableView, T>: NSObject, UICollectionViewDataSource {
    
    //MARK: Properties
    private var cellIdentifier : String
    private var headerViewIdentifier: String?
    private var items : [T]?
    private var headerTitle: String?
    var configureCell : (Cell?, Header?, T?, String?) -> () = {_, _, _, _   in }
    
    
    init(cellIdentifier : String, items : [T], headerViewIdentifier: String?, headerTitle: String?, configureCell :@escaping (Cell?, Header?, T?, String?) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.headerViewIdentifier = headerViewIdentifier
        self.items = items
        self.headerTitle = headerTitle
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
        
        let item = self.items?[indexPath.row]
        self.configureCell(cell, nil, item, nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionHeader", for: indexPath) as! Header
            self.configureCell(nil, headerView, nil, self.headerTitle)
            
            return headerView
            
        default:
            
            return UICollectionReusableView()
        }
    }
    
}
