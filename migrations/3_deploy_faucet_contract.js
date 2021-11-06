const Faucet = artifacts.require("Faucet");

module.exports = function(deployer) {
  deployer.deploy(Faucet, "0xB7813d0F0ff024Feb86F9D3A734d73AF489163A4");
};