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
        
        let pathToModify = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        
        var index: Int
        
        switch cellType {
        case .header(let i):
            index = i
            if view.stateProvider[index] == .expanded {
                view.savoryDelegate.willCollapse?(panelAt: index, in: view)
                view.stateProvider[index] = !view.stateProvider[index]
                view.deleteRows(at: [pathToModify], with: .fade)
                view.savoryDelegate.didCollapse?(panelAt: index, in: view)
            } else {
                view.savoryDelegate.willExpand?(panelAt: index, in: view)
                view.stateProvider[index] = !view.stateProvider[index]
                view.insertRows(at: [pathToModify], with: .fade)
                view.savoryDelegate.didExpand?(panelAt: index, in: view)
            }
        case .body(let i):
            index = i
        }
        
        view.savoryDelegate.didSelect?(panelAt: index, in: view)
    }
    
}
