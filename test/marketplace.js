const Marketplace = artifacts.require("./Marketplace.sol");
const {expectThrow, expectEvent, ether} = require('./helpers');
const BigNumber = web3.BigNumber

contract('Marketplace', ([account, secondAccount, thirdAccount, forthAccount]) => {
    beforeEach(async () => {
        
        this.instance = await Marketplace.new();
    })
    
    it ('only owner can add Admin', async () => {

        
        const list = secondAccount
        await this.instance.addAdmin(list, {from: account})
        await expectThrow(this.instance.addAdmin(list, {from: secondAccount}))
                                                }
        )
    
    it(' only admin can add seller', async () => {

        const list = thirdAccount
        await this.instance.addSeller(list, {from: account})
        await expectThrow(this.instance.addSeller(list, {from: forthAccount}))



    })
    
    it('only seller can add item' , async () => {

        const list = secondAccount
        await this.instance.addSeller(list, {from: account})
        const price = 1000
        const name = "itemname"
        const quantity = 5
        await this.instance.addItem(name, price, quantity, {from: secondAccount})
        await expectThrow(this.instance.addItem(name, price, quantity, {from: thirdAccount}))


    })

    it('only  seller can call withdraw', async () => {
        const list = secondAccount
        await this.instance.addSeller(list, {from: account})
        
        await expectThrow(this.instance.withdraw(list,{from :thirdAccount}))
        await this.instance.withdraw(list,{from:secondAccount})
      })


    it('Buyer buys item' , async () => {
        const id = 3
        await this.instance.buyItem(id,{from: thirdAccount})
    })
}
)