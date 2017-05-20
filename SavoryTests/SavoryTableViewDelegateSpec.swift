//
//  SavoryTableViewDelegateSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
@testable import Savory

class SavoryTableViewDelegateSpec: QuickSpec {
    override func spec() {
        describe("didSelectRowAt") {
            let delegate = SavoryTableViewDelegate.shared
            context("in a normal UITableView") {
                it("raises a precondition failure") {
                    expect {
                        delegate.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
                    } .to(throwAssertion())
                }
            }
            context("in a SavoryView with first panel expanded and others collapsed") {
                var view: SavoryView!
                var dummyDelegate: DummyDelegate!
                beforeEach {
                    view = SavoryView()
                    dummyDelegate = DummyDelegate()
                    view.savoryDelegate = dummyDelegate
                    view.stateProvider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
                }
                context("0 - 1") {
                    beforeEach {
                        delegate.tableView(view, didSelectRowAt: IndexPath(row: 1, section: 0))
                    }
                    it("forwards to the SavoryViewDelegate.didSelectPanelAt with parameter 0") {
                        expect(dummyDelegate.view) === view
                        expect(dummyDelegate.selected) == 0
                    }
                    it("does not collapse first panel") {
                        expect(view.stateProvider[0]) == SavoryPanelState.expanded
                    }
                }
                context("0 - 0") {
                    beforeEach {
                        delegate.tableView(view, didSelectRowAt: IndexPath(row: 0, section: 0))
                    }
                    it("collapses first panel") {
                        expect(view.stateProvider[0]) == SavoryPanelState.collapsed
                    }
                    it("notifies SavoryViewDelegate.willCollapsePanelAt with parameter 0 before collapsing") {
                        expect(dummyDelegate.willCollapse?.index) == 0
                        expect(dummyDelegate.willCollapse?.state) == SavoryPanelState.expanded
                        expect(dummyDelegate.willCollapse?.view) === view
                    }
                    it("notifies SavoryViewDelegate.didCollapsePanelAt with parameter 0 after collapsing") {
                        expect(dummyDelegate.didCollapse?.index) == 0
                        expect(dummyDelegate.didCollapse?.state) == SavoryPanelState.collapsed
                        expect(dummyDelegate.didCollapse?.view) === view
                    }
                    it("does not notify SavoryViewDelegate.willExpandPanelAt") {
                        expect(dummyDelegate.willExpand).to(beNil())
                    }
                    it("does not notify SavoryViewDelegate.didExpandPanelAt") {
                        expect(dummyDelegate.didExpand).to(beNil())
                    }
                }
                context("0 - 2") {
                    beforeEach {
                        delegate.tableView(view, didSelectRowAt: IndexPath(row: 2, section: 0))
                    }
                    it("expands second panel") {
                        expect(view.stateProvider[1]) == SavoryPanelState.expanded
                    }
                    it("notifies SavoryViewDelegate.willExpandPanelAt with parameter 1 before expanding") {
                        expect(dummyDelegate.willExpand?.index) == 1
                        expect(dummyDelegate.willExpand?.state) == SavoryPanelState.collapsed
                        expect(dummyDelegate.willExpand?.view) === view
                    }
                    it("notifies SavoryViewDelegate.didExpandPanelAt with parameter 1 after expanding") {
                        expect(dummyDelegate.didExpand?.index) == 1
                        expect(dummyDelegate.didExpand?.state) == SavoryPanelState.expanded
                        expect(dummyDelegate.didExpand?.view) === view
                    }
                    it("does not notify SavoryViewDelegate.willCollapsePanelAt") {
                        expect(dummyDelegate.willCollapse).to(beNil())
                    }
                    it("does not notify SavoryViewDelegate.didCollapsePanelAt") {
                        expect(dummyDelegate.didCollapse).to(beNil())
                    }
                }
            }
        }
    }
}
