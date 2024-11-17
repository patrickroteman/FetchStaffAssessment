//
//  Recipe.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/16/24.
//

import Foundation

/**
 Represents the Recipe type from the backend. All URLs are actual
 URL types rather than strings. This isn't very important on this scale, but I
 tend to prefer as much static validation as early as possible, so this ensures
 that the strings, if present, are at least valid URLs

 Encodable is not implemented as requirements state to NOT store them locally
 land they are read only from the service so we will not be sending them anywhere.
 In most production code, this would get code generated from some platform agnostic
 data model, for example like with GraphQL end points.
 */
struct Recipe: Decodable, Sendable, Equatable {
	let cuisine: String
	let name: String
	let photoURL: URL?
	let thumbnailURL: URL?
	let id: String
	let sourceURL: URL?
	let youtubeURL: URL?

	enum CodingKeys: String, CodingKey {
		case cuisine
		case name
		case photoURL = "photo_url_large"
		case thumbnailURL = "photo_url_small"
		case id = "uuid"
		case sourceURL = "source_url"
		case youtubeURL = "youtube_url"
	}

	init(cuisine: String, name: String, photoURL: URL?, thumbnailURL: URL?, id: String, sourceURL: URL?, youtubeURL: URL?) {
		self.cuisine = cuisine
		self.name = name
		self.photoURL = photoURL
		self.thumbnailURL = thumbnailURL
		self.id = id
		self.sourceURL = sourceURL
		self.youtubeURL = youtubeURL
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		cuisine = try container.decode(String.self, forKey: .cuisine)
		name = try container.decode(String.self, forKey: .name)
		id = try container.decode(String.self, forKey: .id)

		photoURL = decodeURL(fromContainer: container, forKey: .photoURL)
		thumbnailURL = decodeURL(fromContainer: container, forKey: .thumbnailURL)
		sourceURL = decodeURL(fromContainer: container, forKey: .sourceURL)
		youtubeURL = decodeURL(fromContainer: container, forKey: .youtubeURL)

		// Declared as a nested function for two reasons:
		// 1. Compile error for trying to use the coding key before it is initialized otherwise
		// 2. This only ever makes sense to do within the context of initializing from a Decoder anyway
		func decodeURL(fromContainer container: KeyedDecodingContainer<CodingKeys>,
					   forKey key: Recipe.CodingKeys) -> URL? {
			let URLString = try? container.decode(Optional<String>.self, forKey: key)
			if let URLString {
				return URL(string: URLString)
			} else {
				return nil
			}
		}
	}
}
