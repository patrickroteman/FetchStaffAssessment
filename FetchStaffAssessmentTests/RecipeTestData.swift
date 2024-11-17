//
//  RecipeTestData.swift
//  FetchStaffAssessmentTests
//
//  Created by Patrick Roteman on 11/16/24.
//

import Foundation
@testable import FetchStaffAssessment

struct RecipeTestData {
	static let validRecipeJSONAllValues = """
{
"cuisine": "British",
"name": "Bakewell Tart",
"photo_url_large": "https://some.url/large.jpg",
"photo_url_small": "https://some.url/small.jpg",
"uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
"source_url": "https://some.url/index.html",
"youtube_url": "https://www.youtube.com/watch?v=some.id"
}
"""
	static let validRecipeAllValues = Recipe(
		cuisine: "British",
		name: "Bakewell Tart",
		photoURL: URL(string: "https://some.url/large.jpg"),
		thumbnailURL: URL(string: "https://some.url/small.jpg"),
		id: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
		sourceURL: URL(string: "https://some.url/index.html"),
		youtubeURL: URL(string: "https://www.youtube.com/watch?v=some.id"))
	static let validRecipeJSONMissingSomeURLs = """
{
"cuisine": "American",
"name": "Banana Pancakes",
"photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
"source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
"uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12"
}
"""
	static let validRecipeMissingSomeURLs = Recipe(
		cuisine: "American",
		name: "Banana Pancakes",
		photoURL: nil,
		thumbnailURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
		id: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
		sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
		youtubeURL: nil)
	static let validRecipeParams = zip([
		validRecipeJSONAllValues,
		validRecipeJSONMissingSomeURLs
	], [
		validRecipeAllValues,
		validRecipeMissingSomeURLs
	])
	static let recipeListJSON = """
{ "recipes": [ \(validRecipeJSONAllValues), \(validRecipeJSONMissingSomeURLs) ] }
"""
	static let recipeList = RecipeList(recipes: [validRecipeAllValues, validRecipeMissingSomeURLs])
}
