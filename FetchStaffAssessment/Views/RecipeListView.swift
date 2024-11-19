//
//  ContentView.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/15/24.
//

import SwiftUI

struct RecipeListView: View {

	@ObservedObject var viewModel: RecipeViewModel

	var body: some View {
		NavigationStack {
			List($viewModel.recipes) { recipe in
				RecipeCell(recipe: recipe)
			}
			.refreshable {
				await viewModel.load()
			}
			.task {
				await viewModel.load()
			}
			.padding(0)
			.navigationTitle("Recipes")
			.overlay {
				// Strings and images here would normally be extracted to constants and/or
				// utilities to help with localization, but I'm skipping that for convenience
				if viewModel.failedToLoad {
					ContentUnavailableView("Error loading recipes", systemImage: "x.square").foregroundStyle(.red)
				}
				if viewModel.recipes.isEmpty && viewModel.hasLoaded {
					ContentUnavailableView("No recipes found", systemImage: "doc.richtext.fill")
				}
			}
		}
	}
}

#Preview {
	RecipeListView(viewModel: RecipeViewModel(recipeManager: RecipeManager()))
}
