//
//  MapModels.swift
//  Map
//
//  Created by 西村拓也 on 2022/11/14.
//

import UIKit
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    //CLLocationManager をインスタンス化
    let manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion()
    
    
    override init() {
        super.init() // スーパークラスのイニシャライザを実行
        manager.delegate = self // 自身をデリゲートプロパティに設定
        manager.requestWhenInUseAuthorization() //位置情報を利用許可をリクエスト
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // 精度が低い位置情報で設定
        manager.distanceFilter = 3.0 // 更新距離
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 配列の最後に最新のロケーションが格納される
        // map関数を使って全要素にアクセス map{ $0←要素に参照 }
        locations.last.map {
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude)
            
            // 地図を表示するための領域を再構築
            region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0
            )
            
        }
        
    }
    
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
