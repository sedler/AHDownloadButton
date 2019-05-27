//
//  ProgressButtonTests.swift
//  AHDownloadButton_Tests
//
//  Created by Amer Hukic on 28/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHDownloadButton

class ProgressButtonTests: XCTestCase {

    var progressButton: ProgressButton!
    
    override func setUp() {
        progressButton = ProgressButton()
    }

    override func tearDown() {
        progressButton = nil
    }

    func testSettingCircleLineWidthShouldSetTrackAndProgressCircleLineWidth() {
        progressButton.circleViewLineWidth = 20
        
        let expression = progressButton.circleViewLineWidth == progressButton.trackCircleView.lineWidth && progressButton.circleViewLineWidth == progressButton.progressCircleView.lineWidth
        XCTAssertTrue(expression)
    }
    
    func testSettingProgressLessThanZeroShouldSetProgressToZero() {
        progressButton.setProgress(-2, animated: false)
        XCTAssertTrue(progressButton.progress == 0)
    }
    
    func testSettingProgressGreaterThanOneShouldSetProgressToOne() {
        progressButton.setProgress(2, animated: false)
        XCTAssertTrue(progressButton.progress == 1)
    }
    
    func testSettingProgressShouldSetProgressCircleViewProgress() {
        progressButton.setProgress(0.5, animated: false)
        XCTAssertTrue(progressButton.progress == progressButton.progressCircleView.progress)
    }
    
    func testSettingStopButtonCornerRadiusShouldSetStopViewCornerRadius() {
        progressButton.stopButtonCornerRadius = 3
        XCTAssertTrue(progressButton.stopButtonCornerRadius == progressButton.stopView.layer.cornerRadius)
    }
    
    func testSettingIsHighlightedShouldUpdateProgressButtonColors() {
        progressButton.isHighlighted = true
        XCTAssertTrue(progressButton.trackCircleView.circleColor == progressButton.highlightedTrackCircleColor)
        XCTAssertTrue(progressButton.progressCircleView.circleColor == progressButton.highlightedProgressCircleColor)
        XCTAssertTrue(progressButton.stopView.backgroundColor == progressButton.highlightedStopViewColor)
        
        progressButton.isHighlighted = false
        XCTAssertTrue(progressButton.trackCircleView.circleColor == progressButton.nonhighlightedTrackCircleColor)
        XCTAssertTrue(progressButton.progressCircleView.circleColor == progressButton.nonhighlightedProgressCircleColor)
        XCTAssertTrue(progressButton.stopView.backgroundColor == progressButton.nonhighlightedStopViewColor)
    }
    
}
