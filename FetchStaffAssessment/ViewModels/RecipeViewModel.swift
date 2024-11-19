//
//  RecipeViewModel.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/19/24.
//

import Foundation

/**
 Represents the business logic around Recipes, which in this case is very
 simply just to load them and expose the loading/error states.
 */
@MainActor
final class RecipeViewModel: ObservableObject {

	/**
	 Using very simple manual dependency injection here to make testing
	 this easy. In a more complex app there may be a framework or container
	 approach to make this dependency initialization more robust, but that's
	 not needed here.
	 */
	let recipeManager: RecipeManaging

	init(recipeManager: RecipeManaging) {
		self.recipeManager = recipeManager
	}

	@Published var recipes: [Recipe] = []
	@Published var hasLoaded = false
	@Published var failedToLoad = false

	func load() async {
		failedToLoad = false
		do {
			// For manual testing purposes to validate the UI in error
			// or empty states, you can simply replace this line with
			// recipes = [] to do an empty state
			// or that and failedToLoad = true for error state.
			recipes = try await recipeManager.loadRecipes()
		} catch {
			failedToLoad = true
			recipes = []
		}
		hasLoaded = true
	}
}
