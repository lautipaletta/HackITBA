const mongoose = require("mongoose");

mongoose.connect("mongodb://127.0.0.1/crowdfunding");

const express = require("express");

const cors = require("cors");
const helmet = require("helmet");

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

const modelRaiser = require("./models/raiserModel");
//const modelCrowdFund = require("./models/crowdFundModel");

var port = 3000;

app.post('/loginRaiser', async function (req, res) {
    let id = req.body.id;
    let password = req.body.password;
    await modelRaiser.findOne({ id: id }, function (err, raiser) {
        let response;
        if (err) {
            response = { accessGrated: false, raiser: null };
            return handleError(err);
        }
        response = { accessGrated: false, raiser: null };
        if (raiser.password == password) {
            response = { accessGrated: true, raiser: raiser };
        }
        res.send(response);
    });
});

app.get('/getRaiser', async function (req, res) {
    console.log("id received: ", req.param.id);
    raiser = await modelRaiser.findOne({ id: req.param.id });
    if(raiser){
        delete raiser.password;
        console.log("Sending raiser: ", raiser)
        res.send(raiser);
    }
});

app.post('/newRaiser', async function (req, res) {
    console.log('New Raiser received');
    console.log('body is ', req.body);
    await modelRaiser.insertOne(req.body);
    res.send(req.body);
});

app.listen(port, () => {
    console.log("Listening on port " + port);
});

app.get('/', (req, res) => {
    console.log("Request got");
    res.send("GET Request Called");
})