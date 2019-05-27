//
//  DownloadViewController.swift
//  AHDownloadButton
//
//  Created by Amer Hukić on 09/09/2018.
//  Copyright (c) 2018 Amer Hukić. All rights reserved.
//

import UIKit
import AHDownloadButton

class DownloadViewController: UIViewController {
    
    let downloadButton = AHDownloadButton()
    var downloadTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let width: CGFloat = 450
        let size = CGSize(width: width, height: width / 5)
        let origin = CGPoint(x: view.center.x - size.width / 2, y: view.center.y - size.height / 2)
        downloadButton.frame = CGRect(origin: origin, size: size)
        view.addSubview(downloadButton)
        
        downloadButton.delegate = self
        downloadButton.startDownloadButtonTitle = "DOWNLOAD"
        downloadButton.startDownloadButtonTitleFont = UIFont.boldSystemFont(ofSize: 35)
        downloadButton.startDownloadButtonTitleSidePadding = 40
        
        downloadButton.pendingCircleLineWidth = 5
        downloadButton.downloadingButtonCircleLineWidth = 5

        downloadButton.downloadedButtonTitle = "OPEN"
        downloadButton.downloadedButtonTitleFont = UIFont.boldSystemFont(ofSize: 35)
        downloadButton.downloadedButtonTitleSidePadding = 40
        
    }
    
    func simulateDownloading() {
        downloadTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            guard self.downloadButton.progress < 1 else {
                self.downloadButton.state = .downloaded
                timer.invalidate()
                return
            }
            self.downloadButton.setProgress(self.downloadButton.progress + CGFloat(timer.timeInterval/15), animated: true)
        }
        downloadTimer?.fire()
    }
    
}

extension DownloadViewController: AHDownloadButtonDelegate {

    func downloadButton(_ downloadButton: AHDownloadButton, tappedWithState state: AHDownloadButton.State) {
        switch state {
        case .startDownload:
            downloadTimer?.invalidate()
            downloadButton.setProgress(0, animated: false)
            downloadButton.state = .pending
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.downloadButton.state = .downloading
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.simulateDownloading()
                }
            }
        case .pending:
            break
        case .downloading, .downloaded:
            downloadTimer?.invalidate()
            downloadButton.setProgress(0, animated: false)
            downloadButton.state = .startDownload
        }
    }
    
}
