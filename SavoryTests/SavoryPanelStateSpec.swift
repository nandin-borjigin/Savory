//
//  SavoryPanelStateSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
@testable import Savory

class SavoryPanelStateSpec: QuickSpec {
    override func spec() {
        describe("negate") {
            context(".expanded") {
                it("equals .collapsed") {
                    expect(!SavoryPanelState.collapsed) == SavoryPanelState.expanded
                }
            }
            context(".collapsed") {
                it("equals .expanded") {
                    expect(!SavoryPanelState.expanded) == SavoryPanelState.collapsed
                }
            }
        }
    }
}
