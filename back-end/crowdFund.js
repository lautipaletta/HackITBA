const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");
const modelCrowdFund = require("./models/crowdFundModel");

const {createCrowfundingContract, addDonor, getCollectedAmount} = require("./smartcontracts/smartcontracts");

router.get("/get", async function (req, res) {
    let data = await modelCrowdFund.find({active: 1});
    data = data.sort(String.compare(getCollectedAmount(a.address), getCollectedAmount(b.address)));
    data.map(elem => {
        return {crowdFund: elem, raiser: modelRaiser.findOne({id: elem.idOfRaiser})};
    });
    res.send(data);
});

router.get("/search", async function(req, res){
    const results = await modelCrowdFund.fuzzy(req.query.text);
    res.send(results.sort((a, b) => (a.similarity>b.similarity)? -1 : 1 ).slice(3));
});

router.post("/new", async function (req, res) {
    const data = req.body.crowdFund;
    const raiser = req.body.raiser;

    const contractAddress = await createCrowfundingContract(raiser.address, data.receiverAddress, data.goalAmount, data.deadline);
    data.contractAddress = contractAddress;

    const crowdFund = new modelCrowdFund(data);
    await crowdFund.save();

    const signer = await modelRaiser.findOne({id: raiser.id});
    signer.crowdFundsIds.push(crowdFund.id);
    await signer.save();

    res.send(data);
});

router.post("/donate", async function (req, res){
    const excessFlag = await addDonor(req.body.contractAddress, req.body.senderAddress, req.body.donation);
    if(excessFlag) await modelCrowdFund.findOneAndUpdate({id: req.body.id}, {active: 0});
    res.send({amount: await getCollectedAmount(req.body.contractAddress)});
});

router.post("/getProgress", async function (req, res){
    res.send({amount: await getCollectedAmount(req.body.contractAddress)});
});

module.exports = router;