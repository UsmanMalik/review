var ConsultantReviewContract = artifacts.require("ConsultantReviewContract");

module.exports = function(deployer) {
  deployer.deploy(ConsultantReviewContract);
};