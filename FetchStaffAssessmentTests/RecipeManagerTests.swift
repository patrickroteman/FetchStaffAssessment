//
//  RecipeManagerTests.swift
//  FetchStaffAssessmentTests
//
//  Created by Patrick Roteman on 11/17/24.
//

import Testing
import Foundation
import Mocker
import Alamofire
@testable import FetchStaffAssessment

/**
 Tests that the recipe manager handles various web responses as expected
 and is able to load the recipes by mocking the requests from AlamoFire.
 Uses https://github.com/WeTransfer/Mocker to handle the mocking.

 In a more ideal scenario, the test data mocked here would be crafted to test
 specific scenarios and have more targeted assetions. For convenience, these
 are just copy pasted from the actual json returned by the endpoints with very
 minimal (to the point of the tests not being very useful) assertions.

 Additionally, this mocking library does not work properly when ran in parallel.
 For a large app this would probably be a deal breaker, but for this purpose I
 am just making them serialized rather than find a different library or write the
 functionality myself.
 */
@Suite(.serialized)
struct RecipeManagerTests {

	let recipeManager: RecipeManager = {
		let configuration = URLSessionConfiguration.af.default
		configuration.protocolClasses = [MockingURLProtocol.self]
		let session = Alamofire.Session(configuration: configuration)
		return RecipeManager(session: session)
	}()

    @Test func loadValidData() async throws {
		let json = try JsonLoader.data(forResource: "Recipes", withExtension: "json")
		let mock = Mock(url: recipeManager.recipeURL, statusCode: 200, data: [
			.get: json
		])
		mock.register()
		let recipes = try await recipeManager.loadRecipes()
		#expect(recipes.count > 0)
    }

	@Test func loadEmptyData() async throws {
		let json = try JsonLoader.data(forResource: "EmptyRecipes", withExtension: "json")
		let mock = Mock(url: recipeManager.recipeURL, statusCode: 200, data: [
			.get: json
		])
		mock.register()
		let recipes = try await recipeManager.loadRecipes()
		#expect(recipes.count == 0)
	}

	// MARK: Expected errors
	// In practice these tests should validate the type of the error, and there should be
	// a few more tests to validate other expected error cases such as at least one for 500's
	// responses.

	@Test func loadMalformedData() async throws {
		let json = try JsonLoader.data(forResource: "MalformedRecipes", withExtension: "json")
		let mock = Mock(url: recipeManager.recipeURL, statusCode: 200, data: [
			.get: json
		])
		mock.register()
		await #expect(throws: (AFError).self) {
			try await recipeManager.loadRecipes()
		}
	}

	@Test func loadFrom404() async throws {
		let mock = Mock(url: recipeManager.recipeURL, statusCode: 404, data: [
			.get: "Not Found".data(using: .utf8)!
		])
		mock.register()
		await #expect(throws: (AFError).self) {
			try await recipeManager.loadRecipes()
		}
	}

}

/**
 Defined as a class rather than a struct primarily because accessing the bundle
 requires a class type rather than a struct type.
 */
final class JsonLoader {

	class func data(forResource resource: String, withExtension fileExtension: String) throws -> Data {
		let url = Bundle(for: JsonLoader.self).url(forResource:  resource, withExtension: fileExtension)
		try #require(url != nil)
		return try Data(contentsOf: url!)
	}
}
