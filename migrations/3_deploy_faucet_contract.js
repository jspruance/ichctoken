const Faucet = artifacts.require("Faucet");

module.exports = function(deployer) {
  deployer.deploy(Faucet, "0x8857be9f2505BD6820E310a285CF6096a53e28C3");
};