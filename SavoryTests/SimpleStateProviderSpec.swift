//
//  SimpleStateProviderSpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble
import Savory

class SimpleStateProviderSpec: QuickSpec {
    override func spec() {
        describe("count of provider") {
            context("initialized with empty array") {
                it("equals 0") {
                    let provider = SimpleStateProvider([]) as SavoryStateProvider
                    expect(provider.count) == 0
                }
            }
            context("initialized with non-empty array") {
                it("equals the count of the array") {
                    let provider = SimpleStateProvider([.expanded, .collapsed]) as SavoryStateProvider
                    expect(provider.count) == 2
                }
            }
        }
        describe("subscript") {
            var provider: SavoryStateProvider!
            beforeEach {
                provider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
            }
            describe("getter") {
                it("correctly returns the array elements") {
                    expect(provider[0]) == SavoryPanelState.expanded
                    expect(provider[1]) == SavoryPanelState.collapsed
                    expect(provider[2]) == SavoryPanelState.collapsed
                }
            }
            it("is writable") {
                provider[0] = .collapsed
                expect(provider[0]) == SavoryPanelState.collapsed
                provider[1] = .expanded
                expect(provider[1]) == SavoryPanelState.expanded
                provider[2] = .expanded
                expect(provider[2]) == SavoryPanelState.expanded
            }
        }
    }
}
