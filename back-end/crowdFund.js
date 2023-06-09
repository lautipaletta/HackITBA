const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");
const modelCrowdFund = require("./models/crowdFundModel");

const saveImage = require("./images");

const { createCrowfundingContract, addDonor, getCollectedAmount } = require("./smartcontracts/smartcontracts");

router.get("/get", async function (req, res) {
    let data = await modelCrowdFund.find({ state: 1 });
    for(let crowdFund of data){
        if(crowdFund.deadline < Date.now()){
            crowdFund.state = -1;
            crowdFund.save();
        }
    }

    data = await modelCrowdFund.find({ state: 1 });

    let dataOut = [];
    for (let i = 0; i < data.length; i++) {
        try{
        	const {_id, __v, ...datai} = data[i]._doc;
        	dataOut.push({...datai, collectedAmount: await getCollectedAmount(data[i].contractAddress)});
        
        }catch(err){
            return res.status(404).send({error: err});
        }
    }
    
    res.send(dataOut);
});

router.get("/search", async function (req, res) {
    const results = await modelCrowdFund.fuzzy(req.query.text);
    res.send(results.sort((a, b) => (a.similarity > b.similarity) ? -1 : 1));
});

router.post("/new", async function (req, res) {
    const data = req.body.crowdFund;
    const raiser = req.body.raiser;
    try{
	    const contractAddress = await createCrowfundingContract(raiser.address, data.receiverAddress, data.goalAmount, data.deadline);
	    data.contractAddress = contractAddress;
	    
           data.images = saveImage(req.body.image, req.body.crowdFund.id, req.body.filename);

	    const crowdFund = new modelCrowdFund(data);
	    await crowdFund.save();

	    const signer = await modelRaiser.findOne({id: raiser.id});
	    signer.crowdFundsIds.push(crowdFund.id);
	    await signer.save();

	    res.send({ collectedAmount: "0", ...data });
    }catch(err){
    	res.status(404).send({error: err});
    }

  }
);

router.post("/donate", async function (req, res) {
    try {
        const excessFlag = await addDonor(req.body.contractAddress, req.body.senderAddress, req.body.donation);
        const crowdFund = await modelCrowdFund.findOne({ contractAddress: req.body.contractAddress });
        crowdFund.state = 1 - excessFlag;
        crowdFund.save();
        res.send({ amount: await getCollectedAmount(req.body.contractAddress), state: 1-excessFlag });
    } catch (err) {
    	console.log(err);
        res.status(404).send({ error: err });
    }
});

module.exports = router;
