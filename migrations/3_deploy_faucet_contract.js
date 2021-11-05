const Faucet = artifacts.require("Faucet");

module.exports = function(deployer) {
  deployer.deploy(Faucet, "0x835bd15a761ddbf4fd44b16dcfd5e67f381a72eb");
};