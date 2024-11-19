//
//  FetchStaffAssessmentUITestsLaunchTests.swift
//  FetchStaffAssessmentUITests
//
//  Created by Patrick Roteman on 11/15/24.
//

import XCTest

/**
 - Note: This is unmodified from the app set up as UI tests were out of scope
 */
final class FetchStaffAssessmentUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
