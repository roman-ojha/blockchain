// SPDX-License-Identifier: GPL-3.0
// <SPDX-License-Identifier>: MIT
// <SPDX-License-Identifier>: UNLICENSED

pragma solidity >=0.6.0 <0.9.0;

// pragma solidity 0.6.0;
// pragma solidity ^0.6.0;
// this will allow us to use any 0.6 version, bellow 0.7.0 and above 0.6.0

contract SimpleStorage {
    // types: =============================================================
    // this will get initialized to index 0 contract storage
    uint256 public favoriteNumber = 5;
    int256 favoriteInt = 10; // to index 1
    bool favoriteBool = false; // to index 2
    string favoriteString = "Roman"; // index 3
    address favoriteAddress = 0x45E39E0d7ecc4750530C941dc88D4f5b4772CAac;
    // address is the address of ethereum
    bytes32 favoriteBytes = "cat";

    // struct: =============================================================
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    People public person = People({favoriteNumber: 2, name: "Roman"});

    // function: =============================================================
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrive() public view returns (uint256) {
        // view, pure
        return favoriteNumber;
    }

    // visibility: =================================================================
    // external -> external function can only be able to access outside of the contract
    // public
    // internal -> internal function can be call by other function inside of this contract
    // private

    // Mappings:
    // -> A dictionary like data structure, with 1 value per key
    mapping(string => uint256) public nameToFavoriteNumber;

    // Array: =====================================================================
    People[] public people; // empty dynamic array
    People[3] public people1; // empty fixed sized array

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    // memory, storage
    // memory -> after execution delete that variable
    // storage -> keep it as the instance or permanent
}
