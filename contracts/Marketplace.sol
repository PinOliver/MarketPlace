pragma solidity ^0.5.0;

import "node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract MarketPlace is Ownable {  
    //Mappings

    struct Item {
        string name;
        uint price;
        uint quantity;
    }

    struct seller {
        address  sellerAddress;
        uint256 balance;
        bool isSeller;
    }




    mapping (address => bool) public stores;
    mapping (address => bool) public sellers;
    mapping (address => bool) public admins;
   // mapping (address => Item) public items;

    //Events

    event NewSellerAdded(address _sellerAddress);
    event NewAdminAdded(address _adminAddress);
    event NewStoreAdded(address  storeOwnerAddress);
    event NewItemAdded(string name,  uint256 price, uint256 quantity);
    event PurchaseMade(string name, uint256 quantity);

    //Variables & constructor



    
    //Modifiers

    modifier onlyAdmin() {
        require(admins[msg.sender] == true);
        _;
    }

    modifier onlySeller(){
        require(sellers[msg.sender] == true);
        _;
    }

   //functions


    function addAdmin(address newAdmin) public onlyOwner returns(bool) {
        admins[newAdmin] = true;
        emit NewAdminAdded(newAdmin);
        return admins[newAdmin];
    }

    function addSeller(address newSeller) public onlyAdmin returns(bool){
        sellers[newSeller] = true;
        emit NewSellerAdded(newSeller);
        return sellers[newSeller];   
            
    }

    function addStore(address newStore)public onlySeller returns(bool){
        stores[newStore] = true;
        emit NewStoreAdded(newStore);
        return stores[newStore];
    }

    function addItem(string memory _name, uint256 _price, uint256 _quantity)public onlySeller returns(bool){
        Item.name = _name;
        Item.price = _price;
        Item.quantity = _quantity;
        emit NewItemAdded();
        return [];
    }


}

    
    
  
   