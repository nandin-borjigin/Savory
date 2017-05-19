//
//  SavoryViewSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
import Savory

class DummyView: SavoryView, UITableViewDataSource {
    var indexPath: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "dummy")
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        self.indexPath = indexPath
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "dummy", for: indexPath)
    }
}

class SavoryViewSpec: QuickSpec {
    override func spec() {
        describe("SavoryView") {
            var view: SavoryView!
            beforeEach {
                view = SavoryView()
            }
            it("is a subclass of UITableView") {
                expect(view).to(beAKindOf(UITableView.self))
            }
            describe("rowHeight") {
                it("equals UITableViewAutomaticDimension") {
                    expect(view.rowHeight) == UITableViewAutomaticDimension
                }
                it("doesn't change even when assigned a different value") {
                    view.rowHeight = 100
                    expect(view.rowHeight) == UITableViewAutomaticDimension
                }
            }
            describe("dequeue after an expanded panel and a collapsed panel") {
                var view: DummyView!
                beforeEach {
                    view = DummyView()
                    view.stateProvider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
                    view.savoryDelegate = DummyDelegate()
                    view.headerIdentifier = "header"
                    view.register(UITableViewCell.self, forCellReuseIdentifier: "header")
                    view.bodyIdentifier = "body"
                    view.register(UITableViewCell.self, forCellReuseIdentifier: "body")
                }
                context("header") {
                    var cell: SavoryHeaderCell!
                    beforeEach {
                        cell = view.dequeueReusableHeaderCell(forPanelAt: 2)
                    }
                    it("dequeues cell for 0 - 3") {
                        expect(view.indexPath) == IndexPath(row: 3, section: 0)
                    }
                    it("dequeus cell with headerIdentifier") {
                        expect(cell.reuseIdentifier) == "header"
                    }
                }
                context("body") {
                    var cell: SavoryHeaderCell!
                    beforeEach {
                        cell = view.dequeueReusableBodyCell(forPanelAt: 2)
                    }
                    it("dequeues cell for 0 - 4") {
                        expect(view.indexPath) == IndexPath(row: 4, section: 0)
                    }
                    it("dequeues cell with bodyIdentifier") {
                        expect(cell.reuseIdentifier) == "body"
                    }
                }
            }
        }
    }
}
