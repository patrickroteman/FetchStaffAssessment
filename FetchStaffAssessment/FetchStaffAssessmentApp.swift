//
//  FetchStaffAssessmentApp.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/15/24.
//

import SwiftUI

@main
struct FetchStaffAssessmentApp: App {
	var body: some Scene {
		/**
		 Ideally there would be a container or some sort of dependency injection framework
		 to initialize the RecipeViewModel, which would allow for different versions between
		 the production app and the UI / integration tests. That would allow for tests that do
		 things like verify the different loading states (not loaded, loaded, error, empty) UI
		 in tests, while also skipping over any actual network requests. However, none of that
		 is needed for this scope of an app so I have skipped it.
		 */
		WindowGroup {
			RecipeListView(viewModel: RecipeViewModel(recipeManager: RecipeManager()))
		}
	}
}
