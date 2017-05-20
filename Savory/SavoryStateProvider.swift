//
//  SavoryStateProvider.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

public enum SavoryPanelState {
    case collapsed, expanded
    
    static prefix func!(operand: SavoryPanelState) -> SavoryPanelState {
        switch operand {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }
}

public protocol SavoryStateProvider {
    var count: Int { get }
    subscript(_: Int) -> SavoryPanelState { get set }
}

public struct SimpleStateProvider: SavoryStateProvider {
    public var count: Int { return array.count }
    
    public init(_ array: [SavoryPanelState]) {
        self.array = array
    }
    
    public subscript(_ i: Int) -> SavoryPanelState {
        get { return array[i] }
        set { array[i] = newValue }
    }
    
    private var array: [SavoryPanelState]
}


