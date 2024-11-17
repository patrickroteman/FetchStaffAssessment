//
//  File.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/16/24.
//

import Foundation
import Alamofire

protocol RecipeManaging {
	func loadRecipes() async throws -> [Recipe]
}

/**
 Real implementation of the recipe manager that retrieves the
 data from the various endpoints. The non-standard URLs are
 included for the convenience of interviewers to test app behavior
 with those other responses.
 */
struct RecipeManager: RecipeManaging {

	let recipeURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
	let invalidRecipeURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
	let emptyRecipeURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

	/**
	 Alamofire automatically ensures that the work of serialization happens on a background
	 thread but the result comes back to the thread it was dispatched to (which will always be
	 main for this simple app). This could be adjusted as needed if we were to implement
	 something like a background sync engine where responses may need to go different
	 threads for different purposes.
	 */
	func loadRecipes() async throws -> [Recipe] {
		let result = await AF.request(recipeURL)
			.validate()
			.serializingDecodable(RecipeList.self)
			.result
		switch result {
		case .success(let recipeList):
			return recipeList.recipes
		case .failure(let failure):
			throw failure
		}
	}
}
