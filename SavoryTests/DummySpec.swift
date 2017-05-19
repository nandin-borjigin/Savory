//
//  DummySpec.swift
//  Savory
//
//  Created by Nandiin Borjigin on 20/05/2017.
//  Copyright © 2017 Nandiin Borjigin. All rights reserved.
//

import Quick
import Nimble

class DummySpec: QuickSpec {
    override func spec() {
        describe("dummy") {
            it("should pass") {
                expect(1 + 2) == 3
            }
        }
    }
}
