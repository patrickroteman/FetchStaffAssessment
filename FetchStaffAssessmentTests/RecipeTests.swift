//
//  FetchStaffAssessmentTests.swift
//  FetchStaffAssessmentTests
//
//  Created by Patrick Roteman on 11/15/24.
//

import Testing
import Foundation
@testable import FetchStaffAssessment

/**
 Tests around decoding recipes and the recipe lists
 */
struct RecipeTests {
	
	@Test(arguments: RecipeTestData.validRecipeParams)
	func serializeValidRecipe(JSON: String, recipe expectedRecipe: Recipe) throws {
		try serializeValid(JSON: JSON, expectedItem: expectedRecipe)
    }

	@Test func serializeValidRecipeList() throws {
		try serializeValid(JSON: RecipeTestData.recipeListJSON, expectedItem: RecipeTestData.recipeList)
	}

	func serializeValid<T: Decodable & Equatable>(JSON: String, expectedItem: T) throws {
		let jsonData = JSON.data(using: .utf8)
		try #require(jsonData != nil)
		let decodedItem = try JSONDecoder().decode(T.self, from: jsonData!)
		#expect(decodedItem != nil)
		#expect(decodedItem == expectedItem)
	}

}