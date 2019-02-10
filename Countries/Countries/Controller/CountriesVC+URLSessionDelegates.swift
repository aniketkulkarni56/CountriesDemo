//
//  CountriesVC+URLSessionDelegates.swift
//  Countries
//
//  Created by Aniket K on 2/9/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit

// MARK: - URLSessionDelegate
extension CountriesVC : URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let completionHandler = appDelegate.backgroundSessionCompletionHandler {
            appDelegate.backgroundSessionCompletionHandler = nil
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
