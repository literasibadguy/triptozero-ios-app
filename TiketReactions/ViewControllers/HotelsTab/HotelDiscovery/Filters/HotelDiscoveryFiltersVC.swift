//
//  HotelDiscoveryFiltersVC.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 12/05/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//
import UIKit
import Prelude
import ReactiveSwift
import TiketKitModels

public protocol HotelDiscoveryFiltersDelegate: class {
    func filterParamChanged(_ discovery: HotelDiscoveryFiltersVC, param: SearchHotelParams)
    func filterSortChanged(_ discovery: HotelDiscoveryFiltersVC, sort: SearchHotelParams.Sort)
    func filtersHaveDismissed(_ discovery: HotelDiscoveryFiltersVC)
    
}

public final class HotelDiscoveryFiltersVC: UIViewController, UITableViewDelegate {
    
    fileprivate let viewModel: HotelDiscoveryFiltersViewModelType = HotelDiscoveryFiltersViewModel()
    
    fileprivate let dataSource = HotelDiscoveryFiltersDataSource()
    
    @IBOutlet fileprivate weak var filtersTableView: UITableView!
    
    @IBOutlet fileprivate weak var navBottomView: UIView!
    @IBOutlet fileprivate weak var navSeparatorView: UIView!
    
    @IBOutlet weak var passFilterButton: UIButton!
    
    weak var delegate: HotelDiscoveryFiltersDelegate?
    
    public static func configureWith(envelope: SearchHotelEnvelopes) -> HotelDiscoveryFiltersVC {
        let vc = Storyboard.HotelDiscoveryFilters.instantiate(HotelDiscoveryFiltersVC.self)
        vc.viewModel.inputs.configureWith(envelope)
        return vc
    }
    
    public static func configureWith(sort: SearchHotelParams.Sort) -> HotelDiscoveryFiltersVC {
        let vc = Storyboard.HotelDiscoveryFilters.instantiate(HotelDiscoveryFiltersVC.self)
        vc.viewModel.inputs.configureWith(sort)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizations.FilterButtonTitle
        
        let cancelButtonItem = UIBarButtonItem(title: Localizations.BackbuttonTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButtonItem.tintColor = UIColor.tk_official_green
        
        self.navigationItem.setLeftBarButton(cancelButtonItem, animated: true)
        
        self.passFilterButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        self.filtersTableView.dataSource = dataSource
        self.filtersTableView.delegate = self
        
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func bindStyles() {
        super.bindStyles()
        
        _ = self.filtersTableView
            |> UITableView.lens.separatorStyle .~ .none
            |> UITableView.lens.rowHeight .~ UITableView.automaticDimension
            |> UITableView.lens.estimatedRowHeight .~ 64.0
        
        _ = self.passFilterButton
            |> UIButton.lens.backgroundColor(forState: .normal) .~ .tk_official_green
            |> UIButton.lens.title(forState: .normal) .~ Localizations.ApplybuttonTitle
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        self.passFilterButton.rac.title = self.viewModel.outputs.hotelResultsText
        
        self.viewModel.outputs.loadFilterDataSources
            .observe(on: UIScheduler())
            .observeValues { [weak self] filters in
                self?.dataSource.load()
                self?.filtersTableView.reloadData()
                self?.filtersTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        }
        
        self.viewModel.outputs.selectedSorts
            .observe(on: UIScheduler())
            .observeValues { [weak self] sort in
                guard let _self = self else { return }
                print("What Sort Selected: \(sort)")
                _self.delegate?.filterSortChanged(_self, sort: sort)
                _self.dismiss(animated: true, completion: {
                    _self.delegate?.filtersHaveDismissed(_self)
                })
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sort = self.dataSource.sortAtIndexPath(indexPath) {
            print("WHAT KIND OF SORT: \(sort)")
            self.viewModel.inputs.sortFiltersTapped(sort)
        }
    }
    
    @objc fileprivate func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func confirmButtonTapped() {
        self.viewModel.inputs.confirmFilterButtonTapped()
    }
}
