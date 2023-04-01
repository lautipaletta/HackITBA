const express = require("express");
const mongo = require("mongodb");
let MongoClient = mongo.MongoClient;
const cors = require("cors");
const helmet = require("helmet");
const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

var port = 3000;
const uri = 'mongodb://localhost:27017/';
const client = new MongoClient(uri);

app.listen(port);
console.log("Running!!!");

const dbRaisers = client.db("Foundraisers_Database");
const collRaisers = dbRaisers.collection("Raisers");

collRaisers.insertOne({
    id: "1234",
    name: "Augusto",
    description: "Un tipo peculiar.",
    contactInfo: "Lujan",
    profileImageUrl: "",
    crowdfunds: ""
});

app.get('/getRaiser', async function(req, res) {
    console.log('receiving data ...');
    console.log('body is ', req.body);
    let raiser = await dbRaisers.findOne({id: req.body});
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
    await collRaisers.insertOne(req.body);
    res.send(req.body);
});