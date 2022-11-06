//
//  HouseViewModel.swift
//  Magnar
//
//  Created by Michael Amiro on 03/11/2022.
//

import UIKit

class HouseViewModel: TableViewModel {
    private var state = State()
    private let houseService: HouseServiceDelegate

    var goToHouseDetailView: (House) -> Void = { _ in }

    init(houseService: HouseServiceDelegate = HouseService(networkService: NetworkService())) {
        self.houseService = houseService
        super.init()
        title = "Houses"

        self.sections = [TableSection(id: 0, cells: [])]

        getHouses()
    }

    private func getHouses() {
        houseService.getHouses { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let houses):
                self?.handleGetHousesSuccess(houses)
                print(houses)
            }
        }
    }

    func handleGetHousesSuccess(_ houses: [House]) {
        state.houses = houses
        for index in state.houses.indices {
            let house = state.houses[index]
            let model = HouseFieldModel(name: house.name, region: house.region, numberOfMembers: house.swornMembers.count, overlord: house.overlord)
            sections[0].cells.append(HouseField(tag: index, model: model))
        }
        modelDidUpdate()
    }

    func onRowSelected(indexPath: IndexPath) {
        let selectedCellTag = sections[indexPath.section].cells[indexPath.row].tag
        goToHouseDetailView(state.houses[selectedCellTag])
    }

    struct State {
        var houses: [House] = []
    }
}
