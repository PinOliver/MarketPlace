pragma solidity ^0.5.0;

import "node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";
//import "node_modules/openzeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract MarketPlace is Ownable {  
    
    //Structs

    struct Item {
        uint itemID;
        string name;
        uint256 price;
        uint quantity;
        address  seller;
        address buyer;
    }

    struct seller {
        uint sellerID;
        address  sellerAddress;
        uint256 balance;
        bool isSeller;
    }


    //Mappings
    //mapping (address => bool) public stores;
    mapping (uint => seller) public sellers;
    mapping (address => bool) public admins;
    mapping (address => uint) public sellerIds;
    mapping (uint => Item) public items;
    mapping (address => uint) public itemIds;
    mapping (address => uint256) internal _balances;
    //Events

    event NewSellerAdded(address _sellerAddress);
    event NewAdminAdded(address _adminAddress);
    //event NewStoreAdded(address  storeOwnerAddress);
    event NewItemAdded(string name,  uint256 price, uint quantity);
    event PurchaseMade(string name, uint quantity);
    event WithdrawMade (address _sellerAddress, uint amount);

    //Variables & constructor

    uint SellerCounter ;
    uint ItemCounter ;
    
    //Modifiers

    modifier onlyOwnerandAdmin() {
        
        require((msg.sender == owner()) || (admins[msg.sender] == true));
    
        _;
    }

    modifier onlySeller(){
        require(sellerCheck(msg.sender)); 
        _;
    }

     

   //functions
    function sellerCheck(address sellerAddress) public view returns(bool) {
        uint256 _id = sellerIds[sellerAddress];
        return sellers[_id].isSeller;
    }


    function addAdmin(address newAdmin) public onlyOwner returns(bool) {
        admins[newAdmin] = true;
        emit NewAdminAdded(newAdmin);
        return admins[newAdmin];
    }
    
    function addSeller(address newSeller) public onlyOwnerandAdmin  returns(bool){
        SellerCounter = SellerCounter + 1;
        sellers[SellerCounter] = seller(SellerCounter,newSeller, 0, true);
        sellerIds[newSeller] = SellerCounter;
        emit NewSellerAdded(newSeller);
        return sellers[SellerCounter].isSeller;
    }
    

    /*function addStore(address newStore)public onlySeller returns(bool){
        stores[newStore] = true;
        emit NewStoreAdded(newStore);
        return stores[newStore];
    } */

    function addItem(string memory name, uint256 price, uint256 quantity)public onlySeller{
        ItemCounter = ItemCounter + 1;
        items[ItemCounter] = Item(ItemCounter,name,price,quantity, msg.sender, address(0));
        emit NewItemAdded(name, price, quantity);
        
    }

    
    

    function balance() public view returns (uint256) {
        return _balances[msg.sender];
    }
    
    function withdraw(address sellerAddress) public onlySeller  {
	
        require(sellerAddress == msg.sender);
        uint which = sellerIds[sellerAddress];
        uint withdrawAmount = sellers[which].balance; 
        sellers[which].balance = sellers[which].balance - withdrawAmount; 
        emit  WithdrawMade(msg.sender, withdrawAmount);
    }
                                                       
    function buyItem(uint _id)  public payable  {

        Item storage item = items[_id];
        require(item.buyer == address(0));
        item.buyer = msg.sender;
        uint SellerId = sellerIds[item.seller];
        sellers[SellerId].balance = sellers[SellerId].balance + msg.value;

    }  
}   
