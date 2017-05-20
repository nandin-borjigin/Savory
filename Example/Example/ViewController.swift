//
//  ViewController.swift
//  Example
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import UIKit

import Savory

class ViewController: UIViewController, SavoryViewDelegate {
    // Inherit SavoryViewDelegate Protocol
    // One may provide some standalone struct/class to inherit it
    
    @IBOutlet weak var savoryView: SavoryView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        savoryView.stateProvider = SimpleStateProvider([.expanded, .collapsed, .expanded, .collapsed])
        // set the stateProvider
        // anything conforms to protocol SavoryStateProvider would be fine.
        
        savoryView.savoryDelegate = self
        // set the savoryDelegate
        // not necessarily be view controller itself
        // anything conforms to protocol SavoryViewDelegate would be fine.
        
        savoryView.headerIdentifier = "header"
        savoryView.bodyIdentifier = "body"
        // set the reuse identifiers for header cell and body cell
        // these two identifiers should be somehow registered to the savoryView
        // for this example, they are registered in the storyboard
    }

    func headerCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> SavoryHeaderCell {
        // provide a header cell for (index)-th panel
        let cell = savoryView.dequeueReusableHeaderCell(forPanelAt: index)
        // SavoryView provides a method for dequeueing reusable cells for certain panel index.
        
        // customize the dequeued cell as needed.
        cell.textLabel?.text = "Header \(index)"
        cell.selectionStyle = .none
        return cell
    }
    
    func bodyCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> SavoryBodyCell {
        // provide a body cell for (index)-th panel
        return savoryView.dequeueReusableBodyCell(forPanelAt: index)
    }

}

