var ConsultantContract = artifacts.require("ConsultantContract");

module.exports = function(deployer) {
  deployer.deploy(ConsultantContract);
};