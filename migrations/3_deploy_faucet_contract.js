const Faucet = artifacts.require("Faucet");

module.exports = function(deployer) {
  deployer.deploy(Faucet, "0xcC63c347e32EB44Ed921897b7F8e9Eb1809FC529");
};