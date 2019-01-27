const Marketplace = artifacts.require("./Marketplace.sol");
const {expectThrow, expectEvent, ether} = require('./helpers');
const BigNumber = web3.BigNumber

contract('Marketplace', ([account, secondAccount, thirdAccount, forthAccount]) => {
    beforeEach(async () => {
        
        this.instance = await Marketplace.new();
    })
    // testing wheter only the owner can add an Admin
    // expect failure if no initiated by Admin
    it ('only owner can add Admin', async () => {

        
        const list = secondAccount
        await this.instance.addAdmin(list, {from: account})
        await expectThrow(this.instance.addAdmin(list, {from: secondAccount}))
                                                }
        )
    // testing wheter only Admins can add an seller
    // expect failure if no initiated by Admin or owner
    it(' only admin can add seller', async () => {

        const list = thirdAccount
        await this.instance.addSeller(list, {from: account})
        await expectThrow(this.instance.addSeller(list, {from: forthAccount}))



    })
    // testing wheter only Seller can add an Item
    // expect failure if no initiated by a Seller Account
    it('only seller can add item' , async () => {

        const list = secondAccount
        await this.instance.addSeller(list, {from: account})
        const price = 1000
        const name = "itemname"
        const quantity = 5
        await this.instance.addItem(name, price, quantity, {from: secondAccount})
        await expectThrow(this.instance.addItem(name, price, quantity, {from: thirdAccount}))


    })
     // testing wheter only Seller withdraw
    // expect failure if no initiated by a Seller Account
    it('only  seller can call withdraw', async () => {
        const list = secondAccount
        await this.instance.addSeller(list, {from: account})
        
        await expectThrow(this.instance.withdraw(list,{from :thirdAccount}))
        await this.instance.withdraw(list,{from:secondAccount})
      })

     // testing wheter simple users can buy
    
    it('Buyer buys item' , async () => {
        const id = 3
        await this.instance.buyItem(id,{from: thirdAccount})
    })
}
)
