# Design Pattern usage



## Self Destruction
Initiating a self destruction of the contract 

    function kill() public onlyOwnerandAdmin{
        selfdestruct(msg.sender);
    }

### User access

Specific functions can only be accesed by specific accounts. 

Only the owner and admins can use functions with the "onlyOwnerandAdmin" keyword

modifier onlyOwnerandAdmin() {
        
        require((msg.sender == owner()) || (admins[msg.sender] == true));
    
        _;
    }

Only a seller can use functions with the "onlySeller" keyword

    modifier onlySeller(){
        require(sellerCheck(msg.sender)); 
        _;
    }

     
sellerCheck function :
   
    function sellerCheck(address sellerAddress) public view returns(bool) {
        uint256 _id = sellerIds[sellerAddress];
        return sellers[_id].isSeller;
    }




