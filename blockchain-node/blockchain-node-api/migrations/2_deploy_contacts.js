const LoginWithMetaMask = artifacts.require("./login");

module.exports = function(deployer) {
  deployer.deploy(LoginWithMetaMask);
};