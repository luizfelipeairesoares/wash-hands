//
//  GifServiceTests.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import washands

class GifServiceTests: XCTestCase {
    
    var service: GifService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestGifsSuccess() {
        let mockedResponse = MockResponse()
        service = GifService(session: BaseSessionMock(mockedData: mockedResponse.data(json: "giphyResponse")))
        var success = false
        let expectation = self.expectation(description: "request")
        service.requestGifs { (result) in
            switch result {
            case .success:
                success = true
            case .failure:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssert(success)
    }
    
    func testRequestGifsFailure() {
        service = GifService(session: BaseSessionMock(mockedData: nil))
        var failure = false
        let expectation = self.expectation(description: "request")
        service.requestGifs { (result) in
            switch result {
            case .success:
                break
            case .failure:
                failure = true
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssert(failure)
    }

}
