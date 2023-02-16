//
//  TableCellCarousel+UICollectionViewDelegate.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

//MARK: - UICollectionViewDataSource

extension TableCellCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCarouselList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifire.CollectionCellImage, for: indexPath) as! CollectionCellImage
        let index = indexPath.item
        if let dict = arrCarouselList?[safe: index] {
            let img = dict.image
            cell.strImage = img
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return NumConst.cellSpacing
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension TableCellCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width =  collectionView.frame.width * NumConst.carouselWitdhPercentage
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetWidthForOneItem = caculateContentOffsetForItem(scrollView)
        let offsetForCurrentItem = { CGPoint(x: offsetWidthForOneItem * CGFloat(self.currentCarouselIndex), y: targetContentOffset.pointee.y) }
        
        enum HorizontalDirection { case left, right }
        let horizontalDirection: HorizontalDirection = velocity.x > 0 ? .right : .left
        
        switch horizontalDirection {
        case .left:
            let isFirstItem = currentCarouselIndex <= 0
            guard isFirstItem == false else {
                targetContentOffset.pointee = offsetForCurrentItem()
                return
            }
            
            currentCarouselIndex -= 1
            targetContentOffset.pointee = offsetForCurrentItem()
            
        case .right:
            var count = arrCarouselList?.count ?? 0
            count = count > 0 ? count - 1 : 0
            let isLastItem = (scrollView.contentOffset.x + offsetWidthForOneItem >= scrollView.contentSize.width) || currentCarouselIndex == count
            guard isLastItem == false else {
                targetContentOffset.pointee = offsetForCurrentItem()
                return
            }
            
            currentCarouselIndex += 1
            targetContentOffset.pointee = offsetForCurrentItem()
        }
        
        updatePageControl()
    }
    
    //Calculates content offset
    private func caculateContentOffsetForItem(_ scrollView: UIScrollView) -> CGFloat {
        let cellItemWidth = self.collectionCarousel.frame.width * NumConst.carouselWitdhPercentage
        let sides = scrollView.frame.width - cellItemWidth
        let oneSide: CGFloat = sides/2
        let nextItemVisiblePart = scrollView.frame.width - (oneSide + cellItemWidth + NumConst.cellSpacing)
        return oneSide + (cellItemWidth - nextItemVisiblePart)
    }
    
    private func updatePageControl() {
        let currentPage = pageControl.currentPage
        
        if currentCarouselIndex != currentPage {
            selectedCarouselHandler?(currentCarouselIndex)
            pageControl.currentPage = currentCarouselIndex
        }
    }
}
