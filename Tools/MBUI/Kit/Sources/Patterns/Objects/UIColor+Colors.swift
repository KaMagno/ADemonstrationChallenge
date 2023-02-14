import UIKit

public extension UIColor {
    enum AppColor{
        public static var primary: UIColor {
            MBUIAsset.primary.color
        }
        
        public static var secondary: UIColor {
            MBUIAsset.secondary.color
        }
        
        public static var terciary: UIColor {
            MBUIAsset.terciary.color
        }
        
        public static var text: UIColor {
            MBUIAsset.text.color
        }
        
        public static var bright: UIColor {
            MBUIAsset.bright.color
        }
        
        public static var dark: UIColor {
            MBUIAsset.dark.color
        }
    }
}
