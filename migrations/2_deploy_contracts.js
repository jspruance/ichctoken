const ICanHasCheezburgerToken = artifacts.require("ICanHasCheezburgerToken");

module.exports = function(deployer) {
  // one hundred million coins
  deployer.deploy(ICanHasCheezburgerToken, 100000000, 25);
};