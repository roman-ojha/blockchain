// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "./SimpleStorage.sol";

/*
*) Factory Pattern
    -> we had create a simple storage contract it allowd us to store numbers and store favorite numbers associated with different people, what if we want to have a lot of these simple storage contracts deployed we want the ability to generate and deploy their own list based off of this contract this is where the factory pattern comes into play
*/

contract StorageFactory is SimpleStorage {
    // here we are inheriting from the 'SimpleStorage' Contract now this contract include all the function that are defined in 'SimpleStorage'

    // to deploy 'SimpleStorage' contract using this contract, firstly we have to import 'SimpleStorage' contract into this contract
    // after we have create two or more contract while deploying the contract we have a choice which contract we want to deploy

    // let's make a way to keep track all the different 'SimpleStorage' contract that we deploy by putting them in list or array
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // if we want to deploy 'SimpleStorage' contract using this contract then we have to create 'SimpleStorage'
        SimpleStorage simpleStorage = new SimpleStorage();
        // here we have crate the new contract
        simpleStorageArray.push(simpleStorage);
        // now we are pushing new contract to the array of contract to tract the new contract

        // now if we will deploy 'StorageFactory' Contract and call the function 'createSimpleStorageContract' and then check the 0'th index of 'simpleStorageArray' the we will see the address where the 'SimpleStorage' Contract was deployed to
    }

    // we can also deploy one contract with another contract and call those function as well
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        // in this function we will call the 'SimpleStorage' contract store function

        // any time that we interact with contract we need two things
        // 1. Address
        // 2. ABI (Application Binary Interface)

        // to interact with the 'SimpleStorage' Contract we will pass the address of the simple storage contract
        // <Type_of_Contract>(address(<Array_of_Contract>[<index_of_that_contract>]));
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );
        // this will return the contract that we want to interact with
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // in this function we will view or retrive the 'SimpleStorage' contract 'retrive' function
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );
        return simpleStorage.retrive();
        // or rather then making every function that we had already created in 'SimpleStorage' we can use inheritance
    }
}
