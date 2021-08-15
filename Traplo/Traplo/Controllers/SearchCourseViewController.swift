//
//  SearchCourse.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/15.
//

import Foundation
import UIKit

class SearchCourseViewController : UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // layout
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCourseUnderBoxViewController")
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true, completion: nil)
        
    }
}
