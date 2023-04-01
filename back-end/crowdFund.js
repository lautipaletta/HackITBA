const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");
const modelCrowdFund = require("./models/crowdFundModel");

const {createCrowfundingContract, addDonor, getCollectedAmount} = require("./smartcontracts/smartcontracts");

router.post("/new", async function (req, res) {
    const data = req.body.crowdFund;
    const raiser = req.body.raiser;

    const contractAddress = await createCrowfundingContract(raiser.address, data.receiverAddress, data.goalAmount, data.deadline);
    data.contractAddress = contractAddress;

    const crowdFund = new modelCrowdFund(data);
    await crowdFund.save();

    const signer = await modelRaiser.findOne({id: raiser.id});
    signer.crowdfundsIds.push(crowdFund.id);
    await signer.save();

    res.send(data);
});

router.get("/get", async function (req, res) {
    modelCrowdFund.find().sort((a, b) => getCollectedAmount(a.address) - getCollectedAmount(b.address))
    res.send(data);
});

router.post("/donate", async function (req, res){
    await addDonor(req.body.contractAddress, req.body.senderAddress, req.body.donation);
    res.send({amount: await getCollectedAmount(req.body.contractAddress)});
});

router.post("/getProgress", async function (req, res){
    res.send({amount: await getCollectedAmount(req.body.contractAddress)});
});

module.exports = router;