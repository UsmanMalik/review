var ClientReviewContract = artifacts.require("ClientReviewContract");

module.exports = function(deployer) {
  deployer.deploy(ClientReviewContract);
};