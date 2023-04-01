const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");

router.get('/get', async function (req, res) {
    const raiser = await modelRaiser.findOne({ id: req.query.id });
    if (raiser) {
        const { password, ...response } = raiser._doc;
        res.send({ raiser: response });
    } else {
        res.send({ raiser: null });
    }
});

router.post('/new', async function (req, res) {
    const matches = modelRaiser.findOne({id: req.body.id});
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
    const name = req.body.name;
    const password = req.body.password;
    const response = await modelRaiser.findOne({ name: name });
    if (response) {
        if (raiser.password == password) {
            res.send({ raiser: response });
            return;
        }
    }
    res.send({ raiser: null });
});

module.exports = router;