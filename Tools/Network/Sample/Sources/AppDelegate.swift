import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var mainViewController: UIViewController = {
        .init()
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        open(viewController: mainViewController)
        
        return true
    }

}

private extension AppDelegate {
    func open(viewController: UIViewController, addToANavigationController: Bool = false) {
        var rootViewController = viewController
        
        if addToANavigationController {
            rootViewController = UINavigationController(rootViewController: viewController)
        }
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
