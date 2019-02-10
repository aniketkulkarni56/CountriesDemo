//
//  CountriesVC.swift
//  Countries
//
//  Created by Aniket K on 2/9/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit
import SVGKit
import RxSwift
import RxCocoa

class CountriesVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var disposeBag = DisposeBag()

    var cacheCountries = NSCache<AnyObject, AnyObject>()

    var searchResults: [Country] = []
    let apiManager = APIManager()

    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        return URLSession(configuration: configuration, delegate: self as URLSessionDelegate, delegateQueue: nil)
    }()
    
    func searchCountries(_ query: String) -> Observable<[Country]> {
        apiManager.getSearchResults(searchTerm: query) { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.searchResults = results
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
        return Observable.from(optional: self.searchResults)

    }

    // MARK: - View controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.downloadsSession = downloadsSession
        tblView.tableFooterView = UIView()
        tblView.delegate = nil
        tblView.dataSource = nil

        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Country]> in
                if query.isEmpty {
                    return .just([])
                }
                self.cacheCountries.removeAllObjects()
                return self.searchCountries(query)
                    .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: tblView.rx.items(cellIdentifier: "CountryCell")) {
                (index, countryInfo: Country, cell) in
                if cell is CountryCell
                {
                    let countryCell = (cell as! CountryCell)
                    countryCell.populateData(countryInfo: countryInfo)
                    self.handleLazyImageForCell(countryCell: countryCell, countryInfo: countryInfo)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func handleLazyImageForCell(countryCell: CountryCell, countryInfo: Country)
    {
        DispatchQueue.global().async {
            let data = NSData(contentsOf: URL(string:(countryInfo.flagURL))!)
            DispatchQueue.main.async {
                if data != nil {
                    let urlpath     = Bundle.main.path(forResource: "default_placeholder", ofType: "png")
                    let localDefaultImage = URL(fileURLWithPath: urlpath!)
                    
                    let flagURL = URL(string: countryInfo.flagURL) ?? localDefaultImage
                    countryCell.countryImageView.image = SVGKImage(contentsOf: flagURL)
                    
                    if((countryCell.countryImageView.image) != nil)
                    {
                        self.cacheCountries.setObject(countryCell.countryImageView!, forKey: countryInfo.name as AnyObject)
                    }
                }
            }
        }
    }
}

extension CountriesVC: CountryCellDelegate {
    func saveForOfflineTapped(_ cell: CountryCell) {
    }
}

