//
//  NBAGaloreTests.swift
//  NBAGaloreTests
//
//  Created by Andrea Scapoli on 18/02/21.
//

import XCTest
@testable import NBAGalore

class NBAGaloreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMemoryLeak() {
        
        //weak self in API closures
        let controller = TeamCollectionViewController()
        let network = NetworkManager()
        let viewModel = TeamCollectionViewModel()

        viewModel.networkManager = network
        controller.viewModel = viewModel

        viewModel.retrieveData()

        addTeardownBlock { [weak viewModel] in
             // code here will be executed after teardown

            XCTAssertNil(viewModel)
        }
    }

}
