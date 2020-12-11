//
//  ViewController.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import UIKit

class IceCreamListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var orderButton: UIButton!
    
    var presenter: IceCreamListPresenterType!
    private var iceCreamData = [IceCreamViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    func start() {
        presenter.startProcess()
    }

    @IBAction func orderAction(_ sender: Any) {
        presenter.startOrder()
    }
    
}

extension IceCreamListViewController: IceCreamListViewType {
    func setIceCreams(with: [IceCreamViewData]) {
        iceCreamData = with
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func startLoadingData() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.activityIndicator.startAnimating()
                self.collectionView.isHidden = true
            }
        }
    }
    
    func stopLoadingData() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.activityIndicator.stopAnimating()
                self.collectionView.isHidden = false
            }
        }
    }
    
    func reload(item: IceCreamViewData, at indexPath: IndexPath) {
        iceCreamData[indexPath.row] = item
        collectionView.reloadData()
    }
}

extension IceCreamListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iceCreamData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IceCreamCollectionCell", for: indexPath) as? IceCreamCollectionCell else {
            preconditionFailure("IceCream Collection View Cell not registered in CollectionView")
        }
        
        cell.setup(with: iceCreamData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectElement(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: size, height: size - 80)
    }
    
}

