import UIKit

class HeaderTableView: UIView {
    
    // MARK: Properties
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    // check for scroll, resize image
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offSetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offSetY <= 0
        imageViewBottom.constant = offSetY >= 0 ? 0 : -offSetY / 2
        imageViewHeight.constant = max(offSetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    // MARK: Private Methods
    // Create subviews
    private func createViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    // Set constraints
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        imageViewHeight.isActive = true
    }
}
