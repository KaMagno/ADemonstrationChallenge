import UIKit
import MBUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var mainViewController: UIViewController = {
        MainMenuCreator.create()
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        
        setNavigationBarAppearance()
        open(viewController: mainViewController, addToANavigationController: true)
        
        return true
    }

}

private extension AppDelegate {
    func open(viewController: UIViewController, addToANavigationController: Bool = false) {
        var rootViewController = viewController
        
        if addToANavigationController {
            rootViewController = MBNavigationController(rootViewController: viewController)
        }
        
        rootViewController.modalPresentationStyle = .overFullScreen
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func setNavigationBarAppearance() {
        
    }
}
