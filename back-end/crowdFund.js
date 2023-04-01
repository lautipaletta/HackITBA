const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");
const modelCrowdFund = require("./models/crowdFundModel");

const { createCrowfundingContract, addDonor, getCollectedAmount, checkExpirationDate } = require("./smartcontracts/smartcontracts");

router.get("/get", async function (req, res) {
    let data = await modelCrowdFund.find({ state: 1 });
    data = data.map(x => ({ collectedAmount: getCollectedAmount(x.address), ...x }));
    data = data.sort(String.compare(a.collectedAmount, b.collectedAmount));
    res.send(data);
});

router.get("/search", async function (req, res) {
    const results = await modelCrowdFund.fuzzy(req.query.text);
    res.send(results.sort((a, b) => (a.similarity > b.similarity) ? -1 : 1));
});

router.post("/new", async function (req, res) {
    const data = req.body.crowdFund;
    const raiser = req.body.raiser;

    const contractAddress = await createCrowfundingContract(raiser.address, data.receiverAddress, data.goalAmount, data.deadline);
    data.contractAddress = contractAddress;

    const crowdFund = new modelCrowdFund(data);
    await crowdFund.save();

    const signer = await modelRaiser.findOne({ id: raiser.id });
    signer.crowdFundsIds.push(crowdFund.id);
    await signer.save();

    res.send({ collectedAmount: 0, ...data });
});

router.post("/donate", async function (req, res) {
    try {
        const excessFlag = await addDonor(req.body.contractAddress, req.body.senderAddress, req.body.donation);
        const crowdFund = await modelCrowdFund.findOne({ id: req.body.id });
        crowdFund.state = 1 - excessFlag;
        crowdFund.save();
        res.send({ amount: await getCollectedAmount(req.body.contractAddress), state: excessFlag });
    } catch (err) {
        res.status(404).send({ error: err });
    }
});

module.exports = router;