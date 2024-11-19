//
//  RecipeCell.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/18/24.
//

import SwiftUI
import SDWebImageSwiftUI

/**
 Represents a recipe in the recipe list. As written, it is tightly bound to recipes and so
 gets a binding to an actual recipe object. If this were intended to be a reusable
 component, it might instead declare a protocol that it binds to instead that Recipe
 could conform to for title, secondaryTitle, thumbnailURL, extra links, etc. This is left
 simple as the app is simple. While it's good to demonstrate understanding of what
 good design for a large scale app is, I also am taking the UI code here as an opportunity
 to show how things don't always have to be complicated if the requirements do not
 actually call for it.
 */
struct RecipeCell: View {

	@Binding var recipe: Recipe
	@Environment(\.openURL) private var openURL

	let imageSize = CGFloat(120)

	// These would be localized in more significant apps.
	let youtubeButtonTitle = "Youtube"
	let recipeSourceButtonTitle = "Recipe source"

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
			WebImage(url: recipe.thumbnailURL) { image in
				image.resizable()
			} placeholder: {
				Image("RecipePlaceholder")
					.resizable()
					.scaledToFill()
			}
			.indicator(.activity)
			.scaledToFill()
			.frame(width: imageSize, height: imageSize, alignment: .center)
			.clipped()
			Spacer()
			VStack(alignment: .trailing) {
				Text(recipe.name).font(.headline)
				Spacer()
				Text(recipe.cuisine).font(.subheadline)
				Spacer()
				HStack {
					Button(youtubeButtonTitle) {
						if let youtubeURL = recipe.youtubeURL {
							openURL(youtubeURL)
						}
					}
					.buttonStyle(BorderlessButtonStyle())
					.disabled(recipe.youtubeURL == nil)
					Spacer()
					Button(recipeSourceButtonTitle) {
						if let sourceURL = recipe.sourceURL {
							openURL(sourceURL)
						}
					}
					.buttonStyle(BorderlessButtonStyle())
					.disabled(recipe.sourceURL == nil)
				}
			}
			.frame(height: imageSize, alignment: .center)
		}
	}
}

#Preview {
	@Previewable @State var recipe = Recipe(
		cuisine: "English",
		name: "Apple Crumble",
		photoURL: nil,
		thumbnailURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"),
		id: "Identifier",
		sourceURL: nil,
		youtubeURL: URL(string: "http://www.youtube.com")
	)
	RecipeCell(recipe: $recipe)
}
