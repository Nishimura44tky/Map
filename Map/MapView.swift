//
//  MapView.swift
//  Map
//
//  Created by 西村拓也 on 2022/11/11.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    // 検査キーワードのメンバ変数
    let searchKey :String
    
    //　表示するViewを作成する時に表示
    func makeUIView(context: Context) -> MKMapView {
        
        // MKMapViewのインスタンス生成
        MKMapView() //省略しているが実際は　return MKMapView()
    }
    
    // 表示したViewが更新される度に実行
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // 入力された文字数をデバックエリアに表示
        print(searchKey)
        
        // CLGeocoderインスタンスを取得してgeocoderで定義
        let geocoder = CLGeocoder() //CLGeocodeクラスを使うと軽度緯度から住所を検索可能
        
        // 入力された文字から位置情報を取得
        geocoder.geocodeAddressString (
            searchKey ,
            completionHandler: { (placemarks, error) in //{} inから後クロージャの発動。関数名不要
            
            // もしリクエストの結果が存在し、１件目の情報から位置情報を取り出す
            if let unwrapPlacemarks = placemarks ,
               let firstPlacemark = unwrapPlacemarks.first ,
               let location = firstPlacemark.location {
                
                // 位置情報から軽度緯度をtargetCoordinateに取り出す
                let targetCoordinate = location.coordinate
                // 軽度緯度をデバックエリアに出力
                print(targetCoordinate)
                
                
                // MKPointAnnotationインスタンスを取得し、ピンを生成
                let pin = MKPointAnnotation()
                
                // ピンの置く場所に軽度緯度を設定
                pin.coordinate = targetCoordinate
                
                // ピンのタイトルを設定
                pin.title = searchKey
                
                // ピンを地図に置く
                uiView.addAnnotation(pin)
                
                // 軽度緯度を中心にして半径500mの範囲を表示
                uiView.region = MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0)
                
                
            }
        })
            
            
        }
    
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(searchKey: "東京タワー")
//    }
//}
