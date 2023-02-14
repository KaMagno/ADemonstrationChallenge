import UIKit

public extension UIFont {
    
    // MARK: - Default Fonts
    /// Font with size: **12.0**
    static var xSmall: UIFont {
        .systemFont(ofSize: FontSize.xSmall)
    }
    
    /// Font with size: **14.0**
    static var small: UIFont {
        .systemFont(ofSize: FontSize.small)
    }
    
    /// Font with size: **16.0**
    static var medium: UIFont {
        .systemFont(ofSize: FontSize.medium)
    }
    
    /// Font with size: **18.0**
    static var large: UIFont {
        .systemFont(ofSize: FontSize.large)
    }
    
    /// Font with size: **22.0**
    static var xLarge: UIFont {
        .systemFont(ofSize: FontSize.xLarge)
    }
    
    // MARK: - Styled Fonts
    /// Bold Font with size: **18.0**
    static var title: UIFont {
        .boldSystemFont(ofSize: FontSize.large)
    }
}
