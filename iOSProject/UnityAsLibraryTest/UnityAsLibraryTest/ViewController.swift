//
//  ViewController.swift
//  UnityAsLibraryTest
//
//  Created by Martin Novak on 27/03/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit

// More info here
// https://docs.unity3d.com/Manual/UnityasaLibrary-iOS.html
// https://www.linkedin.com/pulse/how-embed-unity-framework-ios-app-objective-c-swift-malav-soni-/
// https://github.com/Unity-Technologies/uaal-example
// https://github.com/Unity-Technologies/uaal-example/blob/master/docs/ios.md

class ViewController: UIViewController
{
    var unityFramework:UnityFramework?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.removeFromSuperview()
    }

    @IBOutlet var closeButton: UIButton!

    @IBAction func Open(_ sender: Any) {
        initAndShowUnity()
    }
    
    @IBAction func Close(_ sender: Any)
    {
        unityFramework?.unloadApplication()
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
    }
    
    func initAndShowUnity() -> Void
    {
        if let framework = self.unityFrameworkLoad(){
            self.unityFramework = framework
            self.unityFramework?.setDataBundleId("com.unity3d.framework")
            self.unityFramework?.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: [:])
            self.unityFramework?.showUnityWindow()
        }
        
        self.unityFramework?.appController()?.rootView.addSubview(closeButton)
    }
    
    func unityFrameworkLoad() -> UnityFramework?
    {
        let bundlePath = Bundle.main.bundlePath.appending("/Frameworks/UnityFramework.framework")
        if let unityBundle = Bundle.init(path: bundlePath){
            if let frameworkInstance = unityBundle.principalClass?.getInstance(){
               return frameworkInstance
           }
        }
        return nil
    }
}

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
