//
//  AppDelegate.swift
//  StockFootageTV
//
//  Created by Matias Korhonen on 21.10.15.
//  Copyright © 2015 Matias Korhonen. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {

    var window: UIWindow?
    var appController: TVApplicationController?
    let baseURL = "http://localhost:4567"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let context = TVApplicationControllerContext()
        let javaScriptURL = NSURL(string: "\(baseURL)/javascripts/application.js")!

        context.javaScriptApplicationURL = javaScriptURL
        context.launchOptions["BASEURL"] = baseURL

        appController = TVApplicationController(context: context, window: window, delegate: self)
        return true
    }

}
