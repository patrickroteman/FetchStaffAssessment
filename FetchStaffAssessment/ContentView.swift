//
//  ContentView.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/15/24.
//

import SwiftUI

struct ContentView: View {

	let recipe = Recipe(
		cuisine: "English",
		name: "Apple Crumble",
		photoURL: nil,
		thumbnailURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"),
		id: "Identifier",
		sourceURL: nil,
		youtubeURL: nil
	)

    var body: some View {
		RecipeCell(recipe: recipe)
        .padding()
    }
}

#Preview {
    ContentView()
}
