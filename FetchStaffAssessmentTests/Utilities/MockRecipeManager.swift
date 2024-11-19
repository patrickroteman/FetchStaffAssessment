//
//  FakeRecipeManager.swift
//  FetchStaffAssessmentTests
//
//  Created by Patrick Roteman on 11/19/24.
//

import Foundation
@testable import FetchStaffAssessment

enum RecipeManagerResponse {
	case valid
	case empty
	case error
}

enum MockRecipeManagerError: Error {
	case someError
}

/**
 This is a simple fake recipe manager, which will get used in this app
 just for unit tests of the RecipeViewModel. It could also be used in
 UI or integration tests if needed. Fakes can be a strong approach
 separately from using a mocking library in some cases because they
 move the logic of faking dependencies outside of test cases that aren't
 focused on that specific thing. The downside is the boiler plate code
 in setting them up. However, in this case it is so simple that it was
 less work than choosing a mocking library.
 */
struct MockRecipeManager: RecipeManaging {

	let recipes: [Recipe]
	let throwError: Bool

	init(response: RecipeManagerResponse) {
		switch response {
		case .empty:
			recipes = []
			throwError = false

		case .error:
			recipes = []
			throwError = true

		case .valid:
			recipes = RecipeTestData.recipeList.recipes
			throwError = false
		}
	}

	func loadRecipes() async throws -> [Recipe] {
		if throwError {
			throw MockRecipeManagerError.someError
		} else {
			return recipes
		}
	}

}
