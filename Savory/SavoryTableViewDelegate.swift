//
//  SavoryTableViewDelegate.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import UIKit

class SavoryTableViewDelegate: NSObject, UITableViewDelegate {
    static var shared = SavoryTableViewDelegate()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let view = tableView as? SavoryView else {
            precondition(false, "This delegate must be used upon SavoryView")
            return
        }
        
        let cellType = view.savoryDelegate.cellType(at: indexPath, in: view)
        
        var index: Int
        
        switch cellType {
        case .header(let i):
            index = i
            if view.stateProvider[index] == .expanded {
                view.savoryDelegate.willCollapse?(panelAt: index, in: view)
                view.stateProvider[index] = !view.stateProvider[index]
                view.savoryDelegate.didCollapse?(panelAt: index, in: view)
            } else {
                view.savoryDelegate.willExpand?(panelAt: index, in: view)
                view.stateProvider[index] = !view.stateProvider[index]
                view.savoryDelegate.didExpand?(panelAt: index, in: view)
            }
        case .body(let i) : index = i
        }
        
        view.savoryDelegate.didSelect?(panelAt: index, in: view)
    }
    
}
