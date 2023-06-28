import UIKit

class MyViewController : UIViewController {
    var myCollectionView:UICollectionView?
    
    @IBOutlet weak var viewTest: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = UIView()
        test.backgroundColor = .red
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width, height: 80), collectionViewLayout: layout)
        
        
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = UIColor.white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        viewTest.addSubview(myCollectionView ?? UICollectionView())
    }
}

extension MyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.gray
        return myCell
    }
}

extension MyViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

