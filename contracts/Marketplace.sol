pragma solidity ^0.5.0;

import "node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";


/** @title Marketplace */
contract Marketplace is Ownable {  
    
    //Structs

    // Item's struct
    struct Item {
        uint itemID;
        string name;
        uint256 price;
        uint quantity;
        address  seller;
        address buyer;
    }
     
     // seller's struct
    struct seller {
        uint sellerID;
        address  sellerAddress;
        uint256 balance;
        bool isSeller;
    }


    
    //Mappings
    
    mapping (uint => seller) public sellers;
    mapping (address => bool) public admins;
    mapping (address => uint) public sellerIds;
    mapping (uint => Item) public items;
    mapping (address => uint) public itemIds;
    mapping (address => uint256) internal _balances;
    //Events

    event NewSellerAdded(address _sellerAddress);
    event NewAdminAdded(address _adminAddress);
    
    event NewItemAdded(string name,  uint256 price, uint quantity);
    event PurchaseMade(string name, uint quantity);
    event WithdrawMade (address _sellerAddress, uint amount);

    //Variables 

    uint SellerCounter ;
    uint ItemCounter ;
    
    //Modifiers : restricts usage of functions

    modifier onlyOwnerandAdmin() {
        
        require((msg.sender == owner()) || (admins[msg.sender] == true));
    
        _;
    }

    modifier onlySeller(){
        require(sellerCheck(msg.sender)); 
        _;
    }

     

   //functions

    /**  @dev selfdestruct upon calling 
    */
    function kill() public onlyOwnerandAdmin {
        selfdestruct(msg.sender);
    }

    /**  @dev checks if address is a sellerAddress
        @return true ,if is a sellerAddress 
    */
    function sellerCheck(address sellerAddress) public view returns(bool) {
        uint256 _id = sellerIds[sellerAddress];
        return sellers[_id].isSeller;
    }

    /**  @dev Adds an Admin
        @return true, if Added an admin 
    */
    function addAdmin(address newAdmin) public onlyOwner returns(bool) {
        admins[newAdmin] = true;
        emit NewAdminAdded(newAdmin);
        return admins[newAdmin];
    }
    /**  @dev Adds a Seller
        @return true, if Added a Seller 
    */
    function addSeller(address newSeller) public onlyOwnerandAdmin  returns(bool){
        SellerCounter = SellerCounter + 1;
        sellers[SellerCounter] = seller(SellerCounter,newSeller, 0, true);
        sellerIds[newSeller] = SellerCounter;
        emit NewSellerAdded(newSeller);
        return sellers[SellerCounter].isSeller;
    }
    

    
    /**  @dev Adds an Item
        @param name Name of the item
        @param price Price of the item
        @param quantity Quantity of the items
    */
    function addItem(string memory name, uint256 price, uint256 quantity)public onlySeller{
        ItemCounter = ItemCounter + 1;
        items[ItemCounter] = Item(ItemCounter,name,price,quantity, msg.sender, address(0));
        emit NewItemAdded(name, price, quantity);
        
    }

    
    
    /**  @dev checks the balance of account
        @return return with amount of ether in address 
    */
    function balance() public view returns (uint256) {
        return _balances[msg.sender];
    }
    
    /**  @dev Withdraws money from account
        
    */
    function withdraw(address sellerAddress) public onlySeller  {
	
        require(sellerAddress == msg.sender);
        uint which = sellerIds[sellerAddress];
        uint withdrawAmount = sellers[which].balance; 
        sellers[which].balance = sellers[which].balance - withdrawAmount; 
        emit  WithdrawMade(msg.sender, withdrawAmount);
    }

    /**  @dev Buys an item
        @param _id the ID of the item 
    */                              
    function buyItem(uint _id)  public payable  {

        Item storage item = items[_id];
        require(item.buyer == address(0));
        item.buyer = msg.sender;
        uint SellerId = sellerIds[item.seller];
        sellers[SellerId].balance = sellers[SellerId].balance + msg.value;

    }  
}
