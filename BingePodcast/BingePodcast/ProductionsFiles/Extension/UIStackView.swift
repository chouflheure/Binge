import Foundation
import UIKit

extension UIStackView {
    
    func verticalStack() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }
    
    func horizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }
}
