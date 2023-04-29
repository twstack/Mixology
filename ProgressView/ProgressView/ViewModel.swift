//
//  ViewModel.swift
//  ProgressView
//
//  Created by Thomas Stack on 4/18/23.
//

import Foundation

@Published var isLoading = false
    
func getData() async {
    isLoading = true
