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
        }
    }
}
