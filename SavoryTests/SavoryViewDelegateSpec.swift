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
            let indexPath = { IndexPath(row: $0, section: 0) }
            context("header") {
                context("at 0") {
                    it("returns 0 - 0") {
                        expect(delegate.indexPathFor(headerAt: 0, in: view)) == indexPath(0)
                    }
                }
                context("after an expanded panel") {
                    it("returns 0 - 2") {
                        expect(delegate.indexPathFor(headerAt: 1, in: view)) == indexPath(2)
                    }
                }
                context("after an expanded panel and an collapsed panel") {
                    it("returns 0 - 3") {
                        expect(delegate.indexPathFor(headerAt: 2, in: view)) == indexPath(3)
                    }
                }
            }
            context("detail") {
                context("at 0") {
                    it("returns 0 - 1") {
                        expect(delegate.indexPathFor(bodyAt: 0, in: view)) == indexPath(1)
                    }
                }
                context("after an expanded panel") {
                    it("returns 0 - 3") {
                        expect(delegate.indexPathFor(bodyAt: 1, in: view)) == indexPath(3)
                    }
                }
                context("after an expanded panel and an collapsed panel") {
                    it("returns 0 - 4") {
                        expect(delegate.indexPathFor(bodyAt: 2, in: view)) == indexPath(4)
                    }
                }
            }
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
