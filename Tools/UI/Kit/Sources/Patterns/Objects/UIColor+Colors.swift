import UIKit

public extension UIColor {
    enum AppColor{
        public static var primary: UIColor {
            UIAsset.primary.color
        }
        
        public static var secondary: UIColor {
            UIAsset.secondary.color
        }
        
        public static var terciary: UIColor {
            UIAsset.terciary.color
        }
        
        public static var text: UIColor {
            UIAsset.text.color
        }
        
        public static var bright: UIColor {
            UIAsset.bright.color
        }
        
        public static var dark: UIColor {
            UIAsset.dark.color
        }
    }
}
