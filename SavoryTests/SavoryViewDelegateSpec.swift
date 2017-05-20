//
//  SavoryViewDelegateSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
import Savory
@testable import Savory

class DummyDelegate: SavoryViewDelegate {
    weak var view: SavoryView!
    var type: SavoryPanelType!
    var selected: SavoryPanelIndex!
    var willCollapse: (index: Int, state: SavoryPanelState, view: SavoryView)!
    var didCollapse: (index: Int, state: SavoryPanelState, view: SavoryView)!
    var willExpand: (index: Int, state: SavoryPanelState, view: SavoryView)!
    var didExpand: (index: Int, state: SavoryPanelState, view: SavoryView)!
    func headerCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> UITableViewCell {
        view = savoryView
        type = .header(index)
        return UITableViewCell()
    }
    func bodyCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> UITableViewCell {
        view = savoryView
        type = .body(index)
        return UITableViewCell()
    }
    func didSelect(panelAt index: SavoryPanelIndex, in savoryView: SavoryView) {
        selected = index
        view = savoryView
    }
    func willCollapse(panelAt index: SavoryPanelIndex, in savoryView: SavoryView) {
        willCollapse = (index, savoryView.stateProvider[index], savoryView)
    }
    func didCollapse(panelAt index: SavoryPanelIndex, in savoryView: SavoryView) {
        didCollapse = (index, savoryView.stateProvider[index], savoryView)
    }
    func willExpand(panelAt index: SavoryPanelIndex, in savoryView: SavoryView) {
        willExpand = (index, savoryView.stateProvider[index], savoryView)
    }
    func didExpand(panelAt index: SavoryPanelIndex, in savoryView: SavoryView) {
        didExpand = (index, savoryView.stateProvider[index], savoryView)
    }
}
func match(_ expectedValue: SavoryPanelType) -> MatcherFunc<SavoryPanelType> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "match <\(expectedValue)>"
        if let actualValue = try actualExpression.evaluate() {
            if case .header(let i) = expectedValue, case .header(let j) = actualValue {
                return i == j
            } else if case .body(let i) = expectedValue, case .body(let j) = actualValue {
                return i == j
            }
        }
        return false
    }
}

class SavoryViewDelegateSpec: QuickSpec {
    override func spec() {
        var view: SavoryView!
        var delegate: SavoryViewDelegate!
        beforeEach {
            view = SavoryView()
            view.stateProvider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
            delegate = DummyDelegate()
        }
        describe("indexPathFor") {
            
            let indexPathFor: (String, Int) -> (returns: (Int, Int) -> (), dummy: ()) = { (type, i) in
                return ({ (j, k) in
                    context("\(type) at \(i) in a SavoryView with first panel expanded ant others collapsed") {
                        it("returns \(j) - \(k)") {
                            if type == "header" {
                                expect(delegate.indexPathFor(headerAt: i, in: view)) == IndexPath(row: k, section: j)
                            } else {
                                expect(delegate.indexPathFor(bodyAt: i, in: view)) == IndexPath(row: k, section: j)
                            }
                        }
                    }
                }, ())
            }
            
            indexPathFor("header", 0).returns(0, 0)
            indexPathFor("header", 1).returns(0, 2)
            indexPathFor("header", 2).returns(0, 3)
            
            indexPathFor("body", 0).returns(0, 1)
            indexPathFor("body", 1).returns(0, 3)
            indexPathFor("body", 2).returns(0, 4)
        }
        describe("cellType") {
            
            let cellType: (Int, Int) -> (returns: (SavoryPanelType) -> (), dummy: ()) = { (i, j) in
                return ({ ret in
                    context("at \(j) - \(i) with first panel expanded and others collapsed") {
                        it("returns \(ret)") {
                            expect(delegate.cellType(at: IndexPath(row: j, section: i), in: view)).to(match(ret))
                        }
                    }
                }, ())
            }
            
            cellType(0, 0).returns(.header(0))
            cellType(0, 1).returns(.body(0))
            cellType(0, 2).returns(.header(1))
            cellType(0, 3).returns(.header(2))
        }
    }
}
