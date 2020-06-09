//
//  MainViewControllerTests.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 09/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import washands

class GifServiceMock: GifServiceProtocol {
    
    let session: URLSessionProtocol
    
    var expectedResult: Result<[GiphyAPIEntity], APIErrors> = .success([])
    
    required init(session: URLSessionProtocol = BaseSessionMock(mockedData: nil)) {
        self.session = session
    }
    
    func requestGifs(completion: @escaping (Result<[GiphyAPIEntity], APIErrors>) -> Void) {
        completion(expectedResult)
    }
    
}

class MainViewControllerTests: XCTestCase {
    
    private var mockService: GifServiceMock!
    private var viewController: MainViewProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = GifServiceMock()
        viewController = MainViewController(service: mockService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        
        try super.tearDownWithError()
    }

    func testView() throws {
        XCTAssertTrue((viewController as! MainViewController).view is MainView)
    }
    
    func testSuccessRequest() throws {
        mockService.expectedResult = .success([GiphyAPIEntity(id: "", url: "", slug: "", username: "", images: [:])])
        (viewController as! MainViewController).viewDidLoad()
        XCTAssertFalse(viewController.gifs.isEmpty)
    }
    
    func testFailureRequest() throws {
        mockService.expectedResult = .failure(APIErrors.unauthorizedError)
        (viewController as! MainViewController).viewDidLoad()
        XCTAssertTrue(viewController.gifs.isEmpty)
    }

}
