//
//  HouseViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import Foundation

class HouseViewModel: TableViewModel {
    private var state = State()
    private let houseService: HouseServiceDelegate

    init(houseService: HouseServiceDelegate = HouseService(networkService: NetworkService())) {
        self.houseService = houseService
        super.init()
        self.title = "Houses"

        getHouses()
    }

    private func getHouses() {
        houseService.getHouses { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let houses):
                self?.state.houses = houses
                self?.makeSections()
            }
        }
    }

    func onRowSelected(indexPath: IndexPath) {
        let selectedCell = sections[indexPath.section].cells[indexPath.row].tag
        print(selectedCell)
    }

    private func makeSections() {
        let houseCells = state.houses.enumerated().map { item in
            return TableRow(tag: item.element.id, message: item.element.name)
        }
        self.sections = [TableSection(id: 1, cells: houseCells)]
    }

    struct State {
        var houses: [House] = []
    }
}
