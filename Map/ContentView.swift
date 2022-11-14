//
//  ContentView.swift
//  Map
//
//  Created by 西村拓也 on 2022/11/11.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject  var manager = LocationManager()
    
    // ユーザートラッキングモードを追従モードにするための変数を定義
    @State var trackingMode = MapUserTrackingMode.follow
    
    // 入力中の文字列を保持する状態変数
    @State var inputText : String = ""
    
    // 検索キーワードを保持する状態変数
    @State var dispSearchkey : String = ""
    
    
    var body: some View {
        
        // 垂直にレイアウト
        VStack {
         
            // テキストフィールド生成（文字入力）
            TextField("キーワードを入力してください",
            
                      text:  $inputText , onCommit: { //状態変数の指定するときは先頭に$つける
                // 入力が完了したので検索キーワードに設定する
                dispSearchkey = inputText
                
                // 検索キーワードをデバックエリアに出力する
                print("入力したキーワード：" + dispSearchkey )
            })
            
            // 余白を追加
            .padding()
            
            // マップを表示(MapViewを指定)
            MapView(searchKey: dispSearchkey)
            
            
//            Map(coordinateRegion: $manager.region,
//                showsUserLocation: true, // マップ上にユーザーの場所を表示するオプションをBool値で指定
//                userTrackingMode: $trackingMode) // マップがユーザーの位置情報更新にどのように応答するかを決定.edgesIgnoringSafeArea(.bottom)
        }
    }
}


//struct ContentView: View {
//    @ObservedObject  var manager = LocationManager()
//
//    // ユーザートラッキングモードを追従モードにするための変数を定義
//    @State  var trackingMode = MapUserTrackingMode.follow
//        var body: some View {
//
//            Map(coordinateRegion: $manager.region,
//                showsUserLocation: true, // マップ上にユーザーの場所を表示するオプションをBool値で指定
//                userTrackingMode: $trackingMode) // マップがユーザーの位置情報更新にどのように応答するかを決定.edgesIgnoringSafeArea(.bottom)
//
//        }
//
//}
