const ICanHasCheezburgerToken = artifacts.require("ICanHasCheezburgerToken")

contract("ICanHasCheezburgerToken", (accounts) => {
  before(async () => {
      iCHCToken = await ICanHasCheezburgerToken.deployed()
      console.log(`Address: ${iCHCToken.address}`)
  })

  it('the token cap should be 100 million tokens', async () => {
    let cap = await iCHCToken.cap()
    cap = web3.utils.fromWei(cap,'ether')
    assert.equal(cap, 100000000, 'The token cap should be 100 million')
  })

  it('gives the owner of the contract 50 million tokens', async () => {
    let balance = await iCHCToken.balanceOf(accounts[0])
    balance = web3.utils.fromWei(balance,'ether')
    assert.equal(balance, 50000000, 'Balance of contract creator account should be fifty million')
  })

  it('total supply updated after contract creation & transfer to owner', async () => {
    let uncirculatedSupply = await iCHCToken.totalSupply()
    uncirculatedSupply = web3.utils.fromWei(uncirculatedSupply,'ether')
    assert.equal(uncirculatedSupply, 50000000, 'Total supply should now be fifty million')
  })

  it('can transfer tokens between accounts', async () => {
    let amount = web3.utils.toWei('1000','ether')
    await iCHCToken.transfer(accounts[1], amount, {from: accounts[0]})

    let balance = await iCHCToken.balanceOf(accounts[1])
    balance = web3.utils.fromWei(balance,'ether')
    assert.equal(balance, 1000, 'Balance of recipient account should be one thousand')
  })
})