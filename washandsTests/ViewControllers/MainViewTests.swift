//
//  MainViewTests.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 09/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import washands

class MainViewTests: XCTestCase {
    
    var view: MainView!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        view = MainView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
    }
    
    func testSubviews() throws {
        XCTAssertEqual(view.subviews.count, 4)
    }

}
