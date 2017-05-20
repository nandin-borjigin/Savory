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
        return view.stateProvider.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view = tableView as? SavoryView else {
            precondition(false, "This data source must be used upon SavoryView")
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
