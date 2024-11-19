//
//  RecipeViewModelTests.swift
//  FetchStaffAssessmentTests
//
//  Created by Patrick Roteman on 11/19/24.
//

import Testing
@testable import FetchStaffAssessment

/**
 Tests that the expected values get set for the recipes, load,
 and failedToLoad properties in the RecipeViewModel based
 on the response provided to it by the RecipeManager.

 Uses the MockRecipeManager to easily fake the response
 types desired and validate the output.

 Set as a MainActor because the RecipeViewModel is too,
 so it is likely fastest to just run these tests entirely on the
 main thread rather than have a dozen or so dispatches
 across threads all waiting on the main thread anyway
 if the tests were to be executed on different threads.
 */
@MainActor
struct RecipeViewModelTests {

	// Tests that the initialized state of the recipe view model is correct.
	// This is relevant primarily because of the difference between the
	// "not loaded" state and the "empty results" state.
    @Test func dataInitialization() throws {
		let mockManager = MockRecipeManager(response: .error)
		let recipeViewModel = RecipeViewModel(recipeManager: mockManager)
		#expect(recipeViewModel.failedToLoad == false)
		#expect(recipeViewModel.hasLoaded == false)
		#expect(recipeViewModel.recipes == [])
    }

	@Test func dataFailure() async throws {
		let mockManager = MockRecipeManager(response: .error)
		let recipeViewModel = RecipeViewModel(recipeManager: mockManager)
		await recipeViewModel.load()
		#expect(recipeViewModel.failedToLoad == true)
		#expect(recipeViewModel.recipes == [])
	}

	@Test func dataSuccess() async throws {
		let mockManager = MockRecipeManager(response: .valid)
		let recipeViewModel = RecipeViewModel(recipeManager: mockManager)
		await recipeViewModel.load()
		#expect(recipeViewModel.failedToLoad == false)
		#expect(recipeViewModel.recipes == mockManager.recipes)
	}

	@Test func emptyData() async throws {
		let mockManager = MockRecipeManager(response: .empty)
		let recipeViewModel = RecipeViewModel(recipeManager: mockManager)
		await recipeViewModel.load()
		#expect(recipeViewModel.failedToLoad == false)
		#expect(recipeViewModel.recipes == [])
	}

}
