//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import XCTest
@testable import NYCSchools


class MockDataAPIService: DataAPIServiceProtocol {

    var fetchDataResult: Result<Data,ErrorCodes>?

    func fetchDataRequest(url: URL, completion: @escaping (Result<Data, ErrorCodes>) -> Void) {
        if let result = fetchDataResult {
            completion(result)
        }
    }
    
    func fetchJsonData<T:Decodable>(url: URL, completion: @escaping (Result<[T], ErrorCodes>) -> Void)  {
    
    }
}

protocol SchoolsListDataViewModelOutput :AnyObject{
    func updateSchoolView(dataModel:SchoolDataModel)
    func handleError(error:ErrorCodes)
}

class MockSchoolLisDataViewModelOutput:SchoolsListDataViewModelOutput{
    var data:SchoolDataModel?
    var error:ErrorCodes?

    func handleError(error: ErrorCodes) {
        self.error = error
        print(error)
    }
    
    func updateSchoolView(dataModel:SchoolDataModel) {
        data = dataModel
    }
}

final class NYCSchoolsTests: XCTestCase {

       private var sut: SchoolsDataViewModel!
       private var apiService: DataAPIServiceProtocol!
    
       private var mockDatasut: SchoolsDataViewModel!
       private var mockDataAPIService: DataAPIServiceProtocol!
       private var mockDataOutput: SchoolsListDataViewModelOutput!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        apiService = DataTaskAPIService()
        sut = SchoolsDataViewModel(apiService:apiService )
        
      }

    func testSchoolsDataAPIService() { // Real School Data API Call
           //Async APIs has to be tested using expection
           let expectation = self.expectation(description: "SchoolsData")
           
           //Given OR Arrange
           var schoolsData:[(String,String)]?
           
           // when OR Act
           sut.fetchSchoolsData(completion: {result in
               switch result {
               case .success(let data):
                   schoolsData = data
                   expectation.fulfill()
               case .failure(let error):
                   print(error)
               }
           })
           
           self.waitForExpectations(timeout: 4.0, handler: nil)
           
           //Then OR Assert/
           XCTAssertNotNil(schoolsData!)
       }
    
    func testSchoolExtraDataAPIService() { // Real School Data API Call
           //Async APIs has to be tested using expection
           let expectation = self.expectation(description: "SchoolExtraData")
           
           //Given OR Arrange
           var schoolExtraData:String?
           
           // when OR Act
        
           sut.fetchSchoolsExtraData(dbnStr: "08X282", completion: {result in
               switch result {
               case .success(let data):
                   schoolExtraData = data
                   expectation.fulfill()
               case .failure(let error):
                   print(error)
               }
           })
           
           self.waitForExpectations(timeout: 4.0, handler: nil)
           
           //Then OR Assert/
           XCTAssertNotNil(schoolExtraData!)
       }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
