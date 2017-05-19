//
//  SavoryViewDelegate.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

public protocol SavoryViewDelegate {}

public typealias SavoryPanelIndex = Int

internal extension SavoryViewDelegate {
    private func actualRowCount(before index: SavoryPanelIndex, in savoryView: SavoryView) -> Int {
        return (0..<index).reduce(0) { $0 + (savoryView.stateProvider[$1] == .collapsed ? 1 : 2) }
    }
    func indexPathFor(headerAt index: SavoryPanelIndex, in savoryView: SavoryView) -> IndexPath {
        return IndexPath(row: actualRowCount(before: index, in: savoryView), section: 0)
    }
    func indexPathFor(bodyAt index: SavoryPanelIndex, in savoryView: SavoryView) -> IndexPath {
        return IndexPath(row: actualRowCount(before: index, in: savoryView) + 1, section: 0)
    }
}
