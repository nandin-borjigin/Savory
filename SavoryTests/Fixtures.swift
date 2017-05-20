//
//  Fixtures.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Nimble
@testable import Savory

class DummyView: SavoryView {
    var indexPath: IndexPath!
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        self.indexPath = indexPath
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

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
