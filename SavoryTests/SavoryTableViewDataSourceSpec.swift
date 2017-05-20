//
//  SavoryTableViewDataSourceSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
@testable import Savory

class SavoryTableViewDataSourceSpec: QuickSpec {
    override func spec() {
        let dataSource = SavoryTableViewDataSource.shared
        var view: DummyView!
        beforeEach {
            view = DummyView()
            view.stateProvider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
            view.headerIdentifier = "header"
            view.bodyIdentifier = "body"
            view.register(UITableViewCell.self, forCellReuseIdentifier: "header")
            view.register(UITableViewCell.self, forCellReuseIdentifier: "body")
        }
        describe("numberOfSections") {
            context("in a normal UITableView") {
                it("returns 0") {
                    expect(dataSource.numberOfSections(in: UITableView())) == 0
                }
            }
            context("in a SavoryView") {
                it("returns 1") {
                    expect(dataSource.numberOfSections(in: view)) == 1
                }
            }
        }
        describe("numberOfRows") {
            context("in a normal UITableView") {
                it("returns 0") {
                    expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)) == 0
                }
            }
            context("in a SavoryView") {
                it("returns count of state provider") {
                    expect(dataSource.tableView(view, numberOfRowsInSection: 0)) == 3
                }
            }
        }
        describe("cellForRowAt") {
            context("in a normal UITableView") {
                it("raise precondition failure") {
                    expect {
                        _ = dataSource.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
                    } .to(throwAssertion())
                }
            }
            var delegate: DummyDelegate!
            let cellAt: (Int, Int) -> (requests: (String, Int) -> (), dummy: ()) = { (i, j) in
                return ({ (type, k) in
                    context("\(i) - \(j) in a SavoryView with first panel expanded and others collapsed") {
                        beforeEach {
                            _ = dataSource.tableView(view, cellForRowAt: IndexPath(row: j, section: i))
                        }
                        it("requests \(type) cell at \(k) for view from SavoryViewDelegate") {
                            expect(delegate.type).to(match(type == "header" ? .header(k) : .body(k)))
                            expect(delegate.view) === view
                        }
                    }
                }, ())
            }
            
            beforeEach {
                delegate = DummyDelegate()
                view.savoryDelegate = delegate
            }
            
            cellAt(0, 0).requests("header", 0)
            
            cellAt(0, 1).requests("body", 0)
            
            cellAt(0, 2).requests("header", 1)
            
            cellAt(0, 3).requests("header", 2)
        }
    }
}
