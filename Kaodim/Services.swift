//
//  Services.swift
//  Kaodim
//
//  Created by InsightzClub on 22/02/2020.
//  Copyright © 2020 Tharsshinee. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class Services{
   
   //API using Alamofire
    static func getServices(path:String, completion :@escaping (_ result: [List]?) -> Void){
       
        let url = "https://5d1dae5d3374890014f005d1.mockapi.io/api/v1/"
        
        let request =  Alamofire.request("\(url)\(path)", method: .get)
        request.responseJSON { response  in
            guard let data = response.data else {
                print("No Data")
                 completion(nil)
                return
            }
            do{
               let json = try JSONDecoder().decode([List].self, from: data)
                completion(json)
            }catch{
                print(error)
                completion(nil)
            }
        }
    }
    
    // Loading image using Kingfisher
    static func setImageFromUrl(image :String, cell:UITableViewCell) {
        
        let url = URL(string: image)
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(
            with: url,
            placeholder: UIImage(named: "no_image"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
