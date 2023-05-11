import UIKit

public final class NavigationController: UINavigationController {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setupApperance()
        setupTintColor()
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
}


private extension NavigationController {
    func setupTintColor() {
        navigationBar.tintColor = .AppColor.terciary
    }
    
    func setupApperance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .AppColor.primary
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.AppColor.dark
        ]
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.AppColor.dark
        ]
        
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.compactScrollEdgeAppearance = navigationBarAppearance
    }
}
