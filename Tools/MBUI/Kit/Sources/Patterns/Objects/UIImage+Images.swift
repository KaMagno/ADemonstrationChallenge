import UIKit

public extension UIImage {
    enum AppImages {
        /// Symbol: Default Image to use when nil
        public static var defaultWhenNil: UIImage {
            // TODO: Add a default image
            UIImage()
        }
        
        /// Symbol: **􀗁**
        public static var currency: UIImage {
            UIImage(systemName: "coloncurrencysign.circle") ?? AppImages.defaultWhenNil
        }
    }
}
