// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "contracts/SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    //function that creates a simple storage contract and appends it to an array
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint _simpleStorageNumber) public {
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
         
    }


}



