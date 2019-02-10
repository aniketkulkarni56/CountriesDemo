//
//  CountryDetailVC.swift
//  Countries
//
//  Created by 703177707 on 2/11/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit
import SVGKit

class CountryDetailVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
    var countryDetail: Country!
    var countryDetailArray: [[String:String]] = [[String: String]]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableHeaderView?.frame = CGRect.init(x: tblView.frame.origin.x, y: tblView.frame.origin.x, width: tblView.frame.width, height: 200)
        
        if (tblView.tableHeaderView is SVGKFastImageView)
        {
            let svgImageHeaderView = tblView.tableHeaderView as! SVGKFastImageView
            let urlpath     = Bundle.main.path(forResource: "default_placeholder", ofType: "png")
            let localDefaultImage = URL(fileURLWithPath: countryDetail.flagURL)
            
            let flagURL = URL(string: countryDetail.flagURL) ?? localDefaultImage
            svgImageHeaderView.image = SVGKImage(contentsOf: flagURL)
        }

        loadCountryDetail()
        self.title = countryDetail.name
        // Do any additional setup after loading the view.
    }
    
    func loadCountryDetail()
    {
        let capitalDictionary = ["fieldName":"Capital",
                                 "fieldValue":countryDetail.capital]
        countryDetailArray.append(capitalDictionary)

        let regionDictionary = ["fieldName":"Region",
                                 "fieldValue":countryDetail.region]
        countryDetailArray.append(regionDictionary)

        let subRegionDictionary = ["fieldName":"SubRegion",
                                 "fieldValue":countryDetail.subRegion]
        countryDetailArray.append(subRegionDictionary)

        let callingCodeDictionary = ["fieldName":"Calling Codes",
                                 "fieldValue":countryDetail.callingCode]
        countryDetailArray.append(callingCodeDictionary)

        let timeZoneDictionary = ["fieldName":"Time Zones",
                                 "fieldValue":countryDetail.timeZone]
        countryDetailArray.append(timeZoneDictionary)

        let languagesDictionary = ["fieldName":"Languages",
                                  "fieldValue":countryDetail.languages]
        countryDetailArray.append(languagesDictionary)

        let currenciesDictionary = ["fieldName":"Currencies",
                                   "fieldValue":countryDetail.currencies]
        
        countryDetailArray.append(currenciesDictionary)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDataSource

extension CountryDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryDetailCell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailCell", for: indexPath) as! CountryDetailCell
        
        let fieldHash = countryDetailArray[indexPath.row]
        cell.fieldName.text = fieldHash["fieldName"]
        cell.fieldValue.text = fieldHash["fieldValue"]
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CountryDetailVC: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
