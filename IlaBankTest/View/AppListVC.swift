//
//  AppListVC.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

class AppListVC: UIViewController {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var tblList: UITableView!
    
    var viewModel = AppListViewModel()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOnce()
    }
    
    //MARK: - Custom Function
    
    private func loadOnce() {
        viewModel.reloadData = {[weak self] animates in
            self?.reloadTable(animate: animates)
        }
        setupTable()
    }
    
    private func setupTable() {
        tblList.register(UINib(nibName: CellIdentifire.TableCellCarousel, bundle: nil), forCellReuseIdentifier: CellIdentifire.TableCellCarousel)
        tblList.register(UINib(nibName: CellIdentifire.TableCellAppList, bundle: nil), forCellReuseIdentifier: CellIdentifire.TableCellAppList)
        tblList.register(UINib(nibName: CellIdentifire.TableHeaderSearchView, bundle: nil), forHeaderFooterViewReuseIdentifier: CellIdentifire.TableHeaderSearchView)
        
        tblList.dataSource = self
        tblList.delegate = self
        
        //Remove section header blank space
        if #available(iOS 15.0, *) {
            tblList.sectionHeaderTopPadding = 0
        }
        reloadTable()
    }
    
    private func reloadTable(animate: Bool = false) {
        if animate {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.tblList.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        }
    }
    
    //MARK: - deinit
    
    deinit {
        debugPrint("deinit")
    }
}
