//
//  CountriesVC+SearchBarDelegate.swift
//  Countries
//
//  Created by Aniket K on 2/9/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit

extension CountriesVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }

}
