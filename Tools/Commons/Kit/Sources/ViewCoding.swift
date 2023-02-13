import Foundation

public protocol ViewCoding {
    func setupViewHierarchy()
    func setupConstratins()
    func setupAddtionalContent()
    func setupViewCoding()
}

public extension ViewCoding {
    func setupViewCoding() {
        setupViewHierarchy()
        setupConstratins()
        setupAddtionalContent()
    }
    
    func setupAddtionalContent() { }
}
