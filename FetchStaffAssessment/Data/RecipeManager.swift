//
//  File.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/16/24.
//

import Foundation
import Alamofire

/**
 Protocol for the RecipeManager, which in a sizable app would generally
 be how we reference it at all times, with dependency injection to be able
 to swap implementations with a test version when running UI or integration
 tests. None of that exists in this app but that's a good general pattern to
 follow.
 */
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

	let recipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
	let invalidRecipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
	let emptyRecipeURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!

	let session: Session

	/**
	 Inject the dependency on the session to be able to avoid network requests in tests.
	 */
	init(session: Session? = nil) {
		if let session {
			self.session = session
		} else {
			self.session = AF
		}
	}

	/**
	 Alamofire automatically ensures that the work of serialization happens on a background
	 thread but the result comes back to the thread it was dispatched to (which will always be
	 main for this simple app). This could be adjusted as needed if we were to implement
	 something like a background sync engine where responses may need to go different
	 threads for different purposes.

	 Normally for potentially large data sets, this implementation may need to be more
	 complex to handle things like pagination of results. In this case we just have a static
	 list of about 6 recipes so it isn't necessary. It's also good in those sorts of scenarios
	 to build this with generics so that you can have one network manager that can be
	 used to fetch all sorts of models or at least cover the basic CRUD operations for
	 them.
	 */
	func loadRecipes() async throws -> [Recipe] {
		let result = await session.request(recipeURL)
			.validate()
			.serializingDecodable(RecipeList.self)
//			.receive(on: RunLoop.main)
			.result
		switch result {
		case .success(let recipeList):
			return recipeList.recipes
		case .failure(let failure):
			throw failure
		}
	}
}
