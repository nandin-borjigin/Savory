//
//  SavoryView.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import UIKit

public typealias SavoryHeaderCell = UITableViewCell
public typealias SavoryBodyCell = UITableViewCell

open class SavoryView: UITableView {
    override open var rowHeight: CGFloat {
        get { return UITableViewAutomaticDimension }
        set { }
    }
    
    override open var dataSource: UITableViewDataSource? {
        get { return super.dataSource }
        set { }
    }
    
    open override var delegate: UITableViewDelegate? {
        get { return super.delegate }
        set { }
    }
   
    public var savoryDelegate: SavoryViewDelegate!
    
    public var stateProvider: SavoryStateProvider!
    
    public var headerIdentifier: String!
    
    public var bodyIdentifier: String!
    
    public func dequeueReusableHeaderCell(forPanelAt index: SavoryPanelIndex) -> SavoryHeaderCell {
        return dequeueReusableCell(withIdentifier: headerIdentifier, for: savoryDelegate.indexPathFor(headerAt: index, in: self))
    }
    
    public func dequeueReusableBodyCell(forPanelAt index: SavoryPanelIndex) -> SavoryBodyCell {
        return dequeueReusableCell(withIdentifier: bodyIdentifier, for: savoryDelegate.indexPathFor(bodyAt: index, in: self))
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        sharedInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        sharedInit()
    }
    
    private func sharedInit() {
        estimatedRowHeight = 100
        super.dataSource = SavoryTableViewDataSource.shared
        super.delegate = SavoryTableViewDelegate.shared
    }
}
