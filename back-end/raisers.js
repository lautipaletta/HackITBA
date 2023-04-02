const express = require("express");
const router = express.Router();

const modelRaiser = require("./models/raiserModel");
const saveImage = require("./images");

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
    const matches = await modelRaiser.exists({name: req.body.raiser.name});
    if (matches) {
        res.send({isMatch: true});
    } else {
        const raiser = new modelRaiser(req.body.raiser);
        raiser.password = req.body.password;
        raiser.profileImage = saveImage(req.body.image);
        await raiser.save();
        res.send({isMatch: false});
    }
});

router.post('/login', async function (req, res) {
    console.log(req.body);
    const exists = await modelRaiser.exists({ name: req.body.name });
    if(exists){
        const response = await modelRaiser.findOne({ name: req.body.name });
        if (response.password == req.body.password) {
            res.send({ raiser: response });
        }else{
            res.send({ raiser: null });
        }
    }else{
        res.send({ raiser: null });
    }
});

module.exports = router;
