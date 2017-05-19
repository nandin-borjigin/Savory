//
//  SavoryView.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import UIKit

public typealias SavoryHeaderCell = UITableViewCell

open class SavoryView: UITableView {
    override open var rowHeight: CGFloat {
        get { return UITableViewAutomaticDimension }
        set { }
    }
    
    public var savoryDelegate: SavoryViewDelegate!
    
    public var stateProvider: SavoryStateProvider!
    
    public var headerIdentifier: String!
    
    public var bodyIdentifier: String!
    
    public func dequeueReusableHeaderCell(forPanelAt index: SavoryPanelIndex) -> SavoryHeaderCell {
        return dequeueReusableCell(withIdentifier: headerIdentifier, for: savoryDelegate.indexPathFor(headerAt: index, in: self))
    }
    
    public func dequeueReusableBodyCell(forPanelAt index: SavoryPanelIndex) -> SavoryHeaderCell {
        return dequeueReusableCell(withIdentifier: bodyIdentifier, for: savoryDelegate.indexPathFor(bodyAt: index, in: self))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
}
