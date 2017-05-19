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

struct DummyDelegate: SavoryViewDelegate {}

class SavoryViewDelegateSpec: QuickSpec {
    override func spec() {
        describe("indexPathFor") {
            var view: SavoryView!
            var delegate: SavoryViewDelegate!
            let indexPath = { IndexPath(row: $0, section: 0) }
            beforeEach {
                view = SavoryView()
                view.stateProvider = SimpleStateProvider([.expanded, .collapsed, .collapsed])
                delegate = DummyDelegate()
            }
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
    }
}
