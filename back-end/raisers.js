const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");

router.get('/get', async function (req, res) {
    const raiser = await modelRaiser.findOne({ id: req.query.name });
    if (raiser) {
        const { password, ...response } = raiser._doc;
        res.send({ raiser: response });
    } else {
        res.send({ raiser: null });
    }
});

router.post('/new', async function (req, res) {
    const matches = await modelRaiser.exists({name: req.body.raiser.name});
    if (matches) {
        res.send({isMatch: true});
    } else {
        const raiser = new modelRaiser(req.body.raiser);
        raiser.password = req.body.password;
        await raiser.save();
        res.send({isMatch: false});
    }
});

router.post('/login', async function (req, res) {
    const exists = await modelRaiser.exists({ name: req.body.name });
    if(exists){
        const response = await modelRaiser.findOne({ name: req.body.password });
        if (response.password == password) {
            res.send({ raiser: response });
        }else{
            res.send({ raiser: null });
        }
    }else{
        res.send({ raiser: null });
    }
});

module.exports = router;
