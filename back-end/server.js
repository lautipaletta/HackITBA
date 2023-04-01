const mongoose = require("mongoose");

mongoose.connect("mongodb://localhost/crowdfunding", {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true
});

const express = require("express");

const cors = require("cors");
const helmet = require("helmet");

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

const modelRaiser = require("./models/modelRaiser");

var port = 3000;

app.get('/getRaiser', async function(req, res) {
    let raiser = await modelRaiser.findOne({id: req.body});
    let response = {
        "id": raiser.id,
        "name": raiser.name,
        "description": raiser.description,
        "contactInfo": raiser.contactInfo,
        "profileImageUrl": raiser.profileImageUrl,
        "crowdfunds": raiser.crowdfunds
    };
    res.send(response);
});

app.post('/newRaiser', async function(req, res) {
    console.log('receiving data ...');
    console.log('body is ', req.body);
    await modelRaiser.insertOne(req.body);
    res.send(req.body);
});

app.listen(port);
