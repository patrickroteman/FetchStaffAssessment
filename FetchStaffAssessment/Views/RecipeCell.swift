//
//  RecipeCell.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/18/24.
//

import SwiftUI

struct RecipeCell: View {

	let primaryText: String
	let secondaryText: String
	let thumbnailURL: URL?

	let imageSize = CGFloat(120)

	init(recipe: Recipe) {
		primaryText = recipe.name
		secondaryText = recipe.cuisine
		thumbnailURL = recipe.thumbnailURL
	}

	/**
	 I'm sure this isn't the best way to represent this in SwiftUI as I have not much
	 practice at actually directly using SwiftUI. Mostly I've tried to set this up similarly
	 to how I would with UIKit: with an inset UIImageView to the left, and then a
	 container for the labels to the right of it. The labels would be pinned to the
	 top trailing and bottom trailing of that container, and the container would have
	 it's height set to the same as the height of the image. I suspect that thinking
	 of contraints in that way is not a perfect idiom in SwiftUI which I would learn
	 about over the course of time when I start using it for more than a sample
	 project.

	 Also note that normally I wouldn't put the button for youtube and the recipe
	 URL on this screen, but instead link them from a detail page of the recipe.
	 However, the assignment says to have only one screen, so I linked them here
	 instead of making a detail screen which might have had youtube and the source
	 either embedded or linked to in a nicer looking way.
	 */
    var body: some View {
		HStack(alignment: .bottom, spacing: 0) {
			Image(uiImage: UIImage.appleCrumbleSmall)
				.resizable(resizingMode: .stretch)
				.scaledToFill()
				.frame(width: imageSize, height: imageSize, alignment: .center)
				.border(Color.yellow, width: 3)
				.clipped()
			Spacer()
			VStack(alignment: .trailing) {
				Text(primaryText).font(.title2)
				Spacer()
				Text(secondaryText).font(.headline)
				Spacer()
				HStack {
					Button("Youtube") {
						print("Youtube")
					}
					Button("Recipe") {
						print("Recipe")
					}
				}
			}
			.frame(height: imageSize, alignment: .center)
			.border(Color.red)
		}
		.padding()
		.border(Color.blue, width: 3)

	}
}

#Preview {
	let recipe = Recipe(
		cuisine: "English",
		name: "Apple Crumble",
		photoURL: nil,
		thumbnailURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"),
		id: "Identifier",
		sourceURL: nil,
		youtubeURL: nil
	)
	RecipeCell(recipe: recipe)
}
