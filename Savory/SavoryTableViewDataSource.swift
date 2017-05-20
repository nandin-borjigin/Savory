//
//  SavoryTableViewDataSource.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import UIKit

internal class SavoryTableViewDataSource: NSObject, UITableViewDataSource {
    static var shared = SavoryTableViewDataSource()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.isKind(of: SavoryView.self) ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let view = tableView as? SavoryView else { return 0 }
        return (0..<(view.stateProvider?.count ?? 0)).reduce(0) { $0 + (view.stateProvider[$1] == .collapsed ? 1 : 2) }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view = tableView as? SavoryView else {
            precondition(false, "This data source must be used upon SavoryView")
            return UITableViewCell()
        }
        
        let cellType = view.savoryDelegate.cellType(at: indexPath, in: view)
        
        switch cellType {
        case .header(let i):
            return view.savoryDelegate.headerCell(forPanelAt: i, in: view)
        case .body(let i):
            return view.savoryDelegate.bodyCell(forPanelAt: i, in: view)
        }
    }
}
