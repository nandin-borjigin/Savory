//
//  SavoryViewDelegate.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

@objc public protocol SavoryViewDelegate {
    func headerCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> SavoryHeaderCell
    func bodyCell(forPanelAt index: SavoryPanelIndex, in savoryView: SavoryView) -> SavoryBodyCell
    @objc optional func didSelect(panelAt index: SavoryPanelIndex, in savoryView: SavoryView)
    @objc optional func willCollapse(panelAt index: SavoryPanelIndex, in savoryView: SavoryView)
    @objc optional func didCollapse(panelAt index: SavoryPanelIndex, in savoryView: SavoryView)
    @objc optional func willExpand(panelAt index: SavoryPanelIndex, in savoryView: SavoryView)
    @objc optional func didExpand(panelAt index: SavoryPanelIndex, in savoryView: SavoryView)
}

public typealias SavoryPanelIndex = Int

internal enum SavoryPanelType {
    case header(Int), body(Int)
}

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
    func cellType(at indexPath: IndexPath, in savoryView: SavoryView) -> SavoryPanelType {
        var row = 0
        for index in 0..<savoryView.stateProvider.count {
            if row == indexPath.row { return .header(index) }
            else if row > indexPath.row { return .body(index - 1) }
            row += savoryView.stateProvider[index] == .collapsed ? 1 : 2
        }
        return .body(savoryView.stateProvider.count - 1)
    }
}
