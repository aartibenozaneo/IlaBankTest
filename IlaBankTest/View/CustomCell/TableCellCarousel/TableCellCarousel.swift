//
//  TableCellCarousel.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

class TableCellCarousel: UITableViewCell {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var collectionCarousel: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentCarouselIndex = 0
    var arrCarouselList: [CarouselData]?  {
        didSet {
            setupCell()
        }
    }
    
    //Callback to pass selected Carousel index
    var selectedCarouselHandler: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    //MARK: - Custom Functions
    
    private func setupCollection() {
        collectionCarousel.register(UINib(nibName: CellIdentifire.CollectionCellImage, bundle: nil), forCellWithReuseIdentifier: CellIdentifire.CollectionCellImage)
        collectionCarousel.decelerationRate = .fast
        collectionCarousel.dataSource = self
        collectionCarousel.delegate = self
    }
    
    private func setupCell() {
        collectionCarousel.reloadData()
        pageControl.numberOfPages = arrCarouselList?.count ?? 0
    }
}
