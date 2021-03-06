//
//  ViewController.swift
//  DialogViewer
//
//  Created by Domenico on 24.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // Content that we want to display
    fileprivate var sections: [[String: String]]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Mock data
        sections = [
            ["header": "First Witch",
                "content" : "Hey, when will the three of us meet up later?"],
            ["header" : "Second Witch",
                "content" : "When everything's straightened out."],
            ["header" : "Third Witch",
                "content" : "That'll be just before sunset."],
            ["header" : "First Witch",
                "content" : "Where?"],
            ["header" : "Second Witch",
                "content" : "The dirt patch."],
            ["header" : "Third Witch",
                "content" : "I guess we'll see Mac there."]
        ]
        
        // Register the content cell
        collectionView!.register(ContentCell.self,
            forCellWithReuseIdentifier: "CONTENT")
        
        // Register the header cell
        collectionView!.register(HeaderCell.self,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: "HEADER")
        
        // Avoid issue with the status bar
        var contentInset = collectionView!.contentInset
        contentInset.top = 20
        collectionView!.contentInset = contentInset
        
        let layout = collectionView!.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20)
        
        // Size for the header 
        flow.headerReferenceSize = CGSize(width: 100, height: 25)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Helper method
    func wordsInSection(_ section: Int) -> [String] {
        let content = sections[section]["content"]
        let spaces = CharacterSet.whitespacesAndNewlines
        let words = content?.components(separatedBy: spaces)
        return words!
    }
    
    // How many sections to display
    override func numberOfSections(
        in collectionView: UICollectionView) -> Int {
            return sections.count
    }
    
    // How many items for each section
    override func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            let words = wordsInSection(section)
            return words.count
    }
    
    // Returning the cell
    override func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let words = wordsInSection((indexPath as NSIndexPath).section)
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CONTENT", for: indexPath) as! ContentCell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = words[(indexPath as NSIndexPath).row]
            return cell
    }
    
    //- MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let words = wordsInSection((indexPath as NSIndexPath).section)
            let size = ContentCell.sizeForContentString(words[(indexPath as NSIndexPath).row],
                forMaxWidth: collectionView.bounds.size.width)
            return size
    }
    
    override func collectionView(_ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
        -> UICollectionReusableView {
            if (kind == UICollectionElementKindSectionHeader) {
                let cell =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: "HEADER",
                    for: indexPath) as! HeaderCell
                cell.maxWidth = collectionView.bounds.size.width
                cell.text = sections[(indexPath as NSIndexPath).section]["header"]
                return cell
            }
            abort()
    }

}

